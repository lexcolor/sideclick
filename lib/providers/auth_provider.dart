import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/result.dart';
import '../models/user.dart';
import '../models/workspace.dart';
import 'core_providers.dart';

/// Session state for the whole app.
class AuthState {
  final bool loading;
  final bool initialized;
  final ClickUpUser? user;
  final List<Workspace> workspaces;
  final String? selectedTeamId;
  final AppError? error;

  const AuthState({
    this.loading = false,
    this.initialized = false,
    this.user,
    this.workspaces = const [],
    this.selectedTeamId,
    this.error,
  });

  bool get isSignedIn => user != null;

  Workspace? get selectedWorkspace {
    if (selectedTeamId == null) return null;
    for (final w in workspaces) {
      if (w.id == selectedTeamId) return w;
    }
    return workspaces.isNotEmpty ? workspaces.first : null;
  }

  AuthState copyWith({
    bool? loading,
    bool? initialized,
    ClickUpUser? user,
    List<Workspace>? workspaces,
    String? selectedTeamId,
    AppError? error,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      initialized: initialized ?? this.initialized,
      user: clearUser ? null : (user ?? this.user),
      workspaces: workspaces ?? this.workspaces,
      selectedTeamId: selectedTeamId ?? this.selectedTeamId,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthController(this._ref) : super(const AuthState()) {
    _bootstrap();
  }

  /// On launch: restore any saved token, and if present load the session.
  Future<void> _bootstrap() async {
    final auth = _ref.read(authRepositoryProvider);
    final hasToken = await auth.restoreToken();
    if (!hasToken) {
      state = state.copyWith(initialized: true);
      return;
    }
    await _loadSession();
    state = state.copyWith(initialized: true);
  }

  Future<void> signIn(String token) async {
    state = state.copyWith(loading: true, clearError: true);
    final auth = _ref.read(authRepositoryProvider);
    final res = await auth.signIn(token);
    await res.when(
      success: (user) async {
        state = state.copyWith(user: user);
        await _loadWorkspaces();
        state = state.copyWith(loading: false);
      },
      failure: (err) async {
        state = state.copyWith(loading: false, error: err);
      },
    );
  }

  Future<void> _loadSession() async {
    final auth = _ref.read(authRepositoryProvider);
    final userRes = await auth.currentUser();
    await userRes.when(
      success: (user) async {
        state = state.copyWith(user: user);
        await _loadWorkspaces();
      },
      failure: (err) async {
        // Token invalid/expired — force re-login.
        state = state.copyWith(error: err, clearUser: true);
      },
    );
  }

  Future<void> _loadWorkspaces() async {
    final auth = _ref.read(authRepositoryProvider);
    final wsRes = await auth.workspaces();
    await wsRes.when(
      success: (workspaces) async {
        final saved = await auth.selectedTeam();
        final selected = (saved != null &&
                workspaces.any((w) => w.id == saved))
            ? saved
            : (workspaces.isNotEmpty ? workspaces.first.id : null);
        if (selected != null) await auth.setSelectedTeam(selected);
        state = state.copyWith(
          workspaces: workspaces,
          selectedTeamId: selected,
        );
      },
      failure: (err) async {
        state = state.copyWith(error: err);
      },
    );
  }

  Future<void> selectWorkspace(String teamId) async {
    final auth = _ref.read(authRepositoryProvider);
    await auth.setSelectedTeam(teamId);
    state = state.copyWith(selectedTeamId: teamId);
  }

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
    state = const AuthState(initialized: true);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref),
);
