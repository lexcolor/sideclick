import '../core/api/clickup_client.dart';
import '../core/api/endpoints.dart';
import '../core/result.dart';
import '../core/storage/secure_store.dart';
import '../models/user.dart';
import '../models/workspace.dart';

/// Handles token validation, the authenticated user, and workspace loading.
class AuthRepository {
  final ClickUpClient _client;
  final SecureStore _store;

  AuthRepository(this._client, this._store);

  /// Loads a persisted token into the client, if any. Returns true if a token
  /// was found (not necessarily valid).
  Future<bool> restoreToken() async {
    final token = await _store.readToken();
    if (token != null && token.isNotEmpty) {
      _client.setToken(token);
      return true;
    }
    return false;
  }

  /// Validates [token] against `GET /user`. On success, sets it on the client,
  /// persists it, and returns the authenticated user.
  Future<Result<ClickUpUser>> signIn(String token) async {
    _client.setToken(token.trim());
    final res = await _client.get(Endpoints.user);
    return res.when(
      success: (data) async {
        final user = ClickUpUser.fromJson(
            (data as Map)['user'] as Map<String, dynamic>);
        await _store.writeToken(token.trim());
        return Success(user);
      },
      failure: (err) {
        _client.setToken(null);
        return Failure(err);
      },
    );
  }

  /// Fetches the current authenticated user (assumes token already set).
  Future<Result<ClickUpUser>> currentUser() async {
    final res = await _client.get(Endpoints.user);
    return res.when(
      success: (data) =>
          Success(ClickUpUser.fromJson((data as Map)['user'] as Map<String, dynamic>)),
      failure: (err) => Failure(err),
    );
  }

  Future<Result<List<Workspace>>> workspaces() async {
    final res = await _client.get(Endpoints.teams);
    return res.when(
      success: (data) {
        final teams = ((data as Map)['teams'] as List)
            .map((t) => Workspace.fromJson(t as Map<String, dynamic>))
            .toList();
        return Success(teams);
      },
      failure: (err) => Failure(err),
    );
  }

  Future<String?> selectedTeam() => _store.readSelectedTeam();

  Future<void> setSelectedTeam(String teamId) =>
      _store.writeSelectedTeam(teamId);

  Future<void> signOut() async {
    _client.setToken(null);
    await _store.clearAll();
  }
}
