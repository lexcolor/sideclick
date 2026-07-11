/// A lightweight typed result wrapper for repository/API calls, so the UI can
/// distinguish success from a user-facing error without try/catch everywhere.
sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T value) success,
    required R Function(AppError error) failure,
  }) {
    final self = this;
    if (self is Success<T>) return success(self.value);
    return failure((self as Failure<T>).error);
  }
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final AppError error;
  const Failure(this.error);
}

/// A user-facing error with a category so the UI can react (e.g. show a
/// re-login prompt on [AppErrorKind.unauthorized]).
class AppError {
  final AppErrorKind kind;
  final String message;
  final int? statusCode;

  const AppError(this.kind, this.message, {this.statusCode});

  @override
  String toString() => 'AppError($kind, $statusCode): $message';
}

enum AppErrorKind {
  network,
  unauthorized,
  rateLimited,
  notFound,
  server,
  unknown,
}
