import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base/base_consumer_state.dart';
import '../../../../core/base/responsive_utils.dart';
import '../../../../core/theme/app_spacing.dart';
import '../view_model/login_view_model.dart';
import '../widgets/login_form.dart';

/// Login screen. Navigation to Home is handled automatically by the router's
/// auth redirect once [LoginViewModel.submit] promotes the session — this
/// screen only surfaces errors.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Surface errors as a snackbar without rebuilding the whole tree.
    ref.listen(
      loginViewModelProvider.select((s) => s.errorMessage),
      (_, message) {
        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile(context) ? double.infinity : 420,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: context.rh(40)),
                  Text('Welcome back', style: textTheme.displayLarge),
                  AppSpacing.gapSm,
                  Text(
                    'Sign in to continue.',
                    style: textTheme.bodyMedium,
                  ),
                  AppSpacing.gapXxl,
                  const LoginForm(),
                  AppSpacing.gapLg,
                  Text(
                    'Demo: any valid email + 6+ char password works. '
                    'Use fail@example.com to see the error state.',
                    style: textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
