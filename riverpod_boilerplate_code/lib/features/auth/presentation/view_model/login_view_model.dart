import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/common/extension/validator_extension.dart';
import '../../domain/use_case/login_use_case.dart';
import '../controller/auth_controller.dart';
import '../state/login_state.dart';

part 'login_view_model.g.dart';

/// View model for the login screen. Holds [LoginState], runs validation, and
/// drives the [LoginUseCase]. On success it promotes the session via
/// [AuthController] (which the router observes to navigate to Home).
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => LoginState.initial();

  void updateEmail(String email) {
    state = state.copyWith(email: email, errorMessage: '');
    _validate();
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: '');
    _validate();
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void _validate() {
    state = state.copyWith(
      isFormValid: state.email.isValidEmail && state.password.isValidPassword,
    );
  }

  Future<void> submit() async {
    if (state.isLoading) return;
    state = state.copyWith(status: LoginStatus.loading, errorMessage: '');

    final result = await ref.read(loginUseCaseProvider).call(
          email: state.email,
          password: state.password,
        );

    result.when(
      (user) {
        ref.read(authControllerProvider.notifier).onAuthenticated(user);
        state = state.copyWith(status: LoginStatus.success);
      },
      (failure) {
        state = state.copyWith(
          status: LoginStatus.error,
          errorMessage: failure.messageOr('Login failed. Please try again.'),
        );
      },
    );
  }
}
