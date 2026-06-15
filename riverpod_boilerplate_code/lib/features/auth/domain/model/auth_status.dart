/// Session status used by the router to gate routes.
enum AuthStatus {
  /// Startup — still restoring the session from storage. Show a splash.
  unknown,

  /// A valid session exists.
  authenticated,

  /// No session — show the login flow.
  unauthenticated,
}
