import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/primary_button.dart';
import '../../../../core/theme/app_spacing.dart';
import '../state/login_state.dart';
import '../view_model/login_view_model.dart';

/// Stateless, fully VM-driven login form. Reads slices of [LoginState] and
/// forwards events to the [LoginViewModel].
class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Email',
            hint: 'you@example.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            onChanged: vm.updateEmail,
          ),
          AppSpacing.gapLg,
          AppTextField(
            label: 'Password',
            hint: '••••••',
            obscureText: state.obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onChanged: vm.updatePassword,
            suffix: IconButton(
              icon: Icon(
                state.obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: vm.toggleObscurePassword,
            ),
          ),
          AppSpacing.gapXl,
          PrimaryButton(
            label: 'Sign in',
            isLoading: state.isLoading,
            onPressed: state.isFormValid ? vm.submit : null,
          ),
        ],
      ),
    );
  }
}
