import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/auth_status.dart';
import '../../domain/model/user.dart';

part 'auth_state.freezed.dart';

/// App-wide session state held by [AuthController].
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    User? user,
  }) = _AuthState;

  const AuthState._();

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnknown => status == AuthStatus.unknown;
}
