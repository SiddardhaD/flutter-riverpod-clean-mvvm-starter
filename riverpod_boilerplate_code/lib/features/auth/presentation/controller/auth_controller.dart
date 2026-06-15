import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/local/secure_storage/token_storage.dart';
import '../../domain/model/auth_status.dart';
import '../../domain/model/user.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

/// Single source of truth for the session. The router watches this to gate
/// routes, and screens read the current [User] from it.
///
/// On build it restores any persisted session, transitioning from
/// [AuthStatus.unknown] → authenticated / unauthenticated.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    _restore();
    return const AuthState();
  }

  Future<void> _restore() async {
    final hasSession = await ref.read(tokenStorageProvider).hasSession();
    state = state.copyWith(
      status:
          hasSession ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  /// Called by the login view model after a successful sign-in (tokens are
  /// already persisted by the use case).
  void onAuthenticated(User user) {
    state = state.copyWith(status: AuthStatus.authenticated, user: user);
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clear();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}
