/// Route names + paths in one place. Reference these constants instead of
/// hardcoding strings at call sites (`context.goNamed(AppRoute.home)`).
class AppRoute {
  AppRoute._();

  static const String splash = 'splash';
  static const String splashPath = '/';

  static const String login = 'login';
  static const String loginPath = '/login';

  static const String home = 'home';
  static const String homePath = '/home';
}
