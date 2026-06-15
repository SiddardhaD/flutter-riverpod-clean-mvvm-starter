import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

/// Shown while [AuthController] restores the session on startup. The router
/// redirects away from here once the status resolves.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt_rounded, size: 64, color: scheme.primary),
            AppSpacing.gapLg,
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
