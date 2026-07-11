import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core_providers.dart';

/// Holds the app's theme mode (system/light/dark), hydrated from and persisted
/// to the local store so the choice survives restarts.
class ThemeModeController extends StateNotifier<ThemeMode> {
  final Ref _ref;

  ThemeModeController(this._ref) : super(ThemeMode.system) {
    _hydrate();
  }

  Future<void> _hydrate() async {
    final saved = await _ref.read(secureStoreProvider).readThemeMode();
    state = _fromString(saved);
  }

  void set(ThemeMode mode) {
    state = mode;
    _ref.read(secureStoreProvider).writeThemeMode(_toString(mode));
  }

  static ThemeMode _fromString(String? s) {
    switch (s) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static String _toString(ThemeMode m) {
    switch (m) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>(
  (ref) => ThemeModeController(ref),
);
