import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/login_screen.dart';
import 'features/tasks/task_list_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';

class SideClickApp extends ConsumerWidget {
  const SideClickApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final themeMode = ref.watch(themeModeProvider);

    const seed = Color(0xFF3B82F6);

    return MaterialApp(
      title: 'SideClick',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      home: _Root(auth: auth),
    );
  }
}

class _Root extends StatelessWidget {
  final AuthState auth;
  const _Root({required this.auth});

  @override
  Widget build(BuildContext context) {
    if (!auth.initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (!auth.isSignedIn) {
      return const LoginScreen();
    }
    return const TaskListScreen();
  }
}
