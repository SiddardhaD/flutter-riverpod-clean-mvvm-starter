import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/domain/model/auth_status.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../../features/auth/presentation/ui/login_screen.dart';
import '../../features/home/presentation/ui/home_screen.dart';
import '../../features/splash/presentation/ui/splash_screen.dart';
import 'named_route.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// The app [GoRouter].
///
/// Auth gating lives in [redirect], driven by [AuthController]:
///  - while the session is restoring ([AuthStatus.unknown]) → splash,
///  - authenticated users are kept out of `/login`,
///  - unauthenticated users are bounced to `/login`.
///
/// A [ValueNotifier] bridges the auth state into GoRouter's
/// `refreshListenable` so redirects re-run whenever the session changes.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ValueNotifier<AuthStatus>(AuthStatus.unknown);
  ref.onDispose(refresh.dispose);
  ref.listen(
    authControllerProvider.select((s) => s.status),
    (_, next) => refresh.value = next,
    fireImmediately: true,
  );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.splashPath,
    refreshListenable: refresh,
    redirect: (context, state) {
      final status = ref.read(authControllerProvider).status;
      final loc = state.matchedLocation;

      if (status == AuthStatus.unknown) {
        return loc == AppRoute.splashPath ? null : AppRoute.splashPath;
      }

      final loggingIn = loc == AppRoute.loginPath;
      final onSplash = loc == AppRoute.splashPath;

      if (status == AuthStatus.unauthenticated) {
        return loggingIn ? null : AppRoute.loginPath;
      }

      // Authenticated: keep away from splash/login.
      if (loggingIn || onSplash) return AppRoute.homePath;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoute.splashPath,
        name: AppRoute.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.loginPath,
        name: AppRoute.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.homePath,
        name: AppRoute.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
