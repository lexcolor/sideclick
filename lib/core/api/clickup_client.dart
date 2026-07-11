import 'package:dio/dio.dart';

import '../result.dart';
import 'endpoints.dart';

/// Thin wrapper around Dio configured for the ClickUp API. Injects the personal
/// API token into the `Authorization` header and maps errors to [AppError].
///
/// The token is held in memory and set via [setToken]; persistence is handled
/// separately by SecureStore.
class ClickUpClient {
  final Dio _dio;
  String? _token;

  ClickUpClient({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: Endpoints.base,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 30),
            )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _token;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = token;
        }
        handler.next(options);
      },
    ));
  }

  void setToken(String? token) => _token = token;

  bool get hasToken => _token != null && _token!.isNotEmpty;

  Dio get raw => _dio;

  /// GET returning the decoded JSON body.
  Future<Result<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return _run(() => _dio.get(path, queryParameters: query));
  }

  Future<Result<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
  }) async {
    return _run(() => _dio.post(path, data: data, queryParameters: query));
  }

  Future<Result<dynamic>> put(String path, {Object? data}) async {
    return _run(() => _dio.put(path, data: data));
  }

  Future<Result<dynamic>> delete(String path, {Object? data}) async {
    return _run(() => _dio.delete(path, data: data));
  }

  Future<Result<T>> _run<T>(Future<Response<T>> Function() call) async {
    try {
      final res = await call();
      return Success(res.data as T);
    } on DioException catch (e) {
      return Failure(_mapError(e));
    } catch (e) {
      return Failure(AppError(AppErrorKind.unknown, e.toString()));
    }
  }

  AppError _mapError(DioException e) {
    final status = e.response?.statusCode;
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const AppError(
          AppErrorKind.network, 'No connection to ClickUp. Check your network.');
    }
    switch (status) {
      case 401:
      case 403:
        return AppError(AppErrorKind.unauthorized,
            'Your API token was rejected. Please re-enter it.',
            statusCode: status);
      case 404:
        return AppError(AppErrorKind.notFound, 'Not found.',
            statusCode: status);
      case 429:
        return AppError(AppErrorKind.rateLimited,
            'Rate limited by ClickUp. Try again shortly.',
            statusCode: status);
      default:
        if (status != null && status >= 500) {
          return AppError(AppErrorKind.server, 'ClickUp server error.',
              statusCode: status);
        }
        final msg = _extractMessage(e.response?.data) ?? e.message ?? 'Request failed.';
        return AppError(AppErrorKind.unknown, msg, statusCode: status);
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map && data['err'] is String) return data['err'] as String;
    if (data is Map && data['error'] is String) return data['error'] as String;
    return null;
  }
}
