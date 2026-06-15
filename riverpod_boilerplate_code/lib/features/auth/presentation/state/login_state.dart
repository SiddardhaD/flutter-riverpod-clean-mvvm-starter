import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

enum LoginStatus { idle, loading, success, error }

/// Immutable UI state for the login screen, owned by [LoginViewModel].
@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool obscurePassword,
    @Default(false) bool isFormValid,
    @Default(LoginStatus.idle) LoginStatus status,
    @Default('') String errorMessage,
  }) = _LoginState;

  const LoginState._();

  bool get isLoading => status == LoginStatus.loading;

  factory LoginState.initial() => const LoginState(obscurePassword: true);
}
