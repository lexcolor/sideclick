import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _controller = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final token = _controller.text.trim();
    if (token.isEmpty) return;
    await ref.read(authControllerProvider.notifier).signIn(token);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.check_circle_outline,
                    size: 56, color: theme.colorScheme.primary),
                const SizedBox(height: 16),
                Text('SideClick',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'Your ClickUp tasks, without the clutter.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _controller,
                  obscureText: _obscure,
                  autofocus: true,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Personal API token',
                    hintText: 'pk_...',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                if (auth.error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    auth.error!.message,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: auth.loading ? null : _submit,
                  child: auth.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Connect'),
                ),
                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline),
                    children: [
                      const TextSpan(
                          text:
                              'Get your token from ClickUp → Settings → Apps. '),
                      TextSpan(
                        text: 'Open ClickUp settings',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(
                                Uri.parse('https://app.clickup.com/settings/apps'),
                                mode: LaunchMode.externalApplication,
                              ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
