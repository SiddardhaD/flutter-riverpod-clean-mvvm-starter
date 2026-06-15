/// Static app configuration.
///
/// In a real app, back these with build flavors / `--dart-define` /
/// `flutter_dotenv`. Kept as plain constants here so the boilerplate runs
/// with zero setup.
class AppConfig {
  AppConfig._();

  /// Base URL for the REST API. The sample auth repository mocks responses,
  /// so this is only used to demonstrate wiring Dio + Retrofit.
  static const String apiBaseUrl = 'https://api.example.com/';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Flip to true to send simulated (mock) responses from repositories
  /// instead of hitting the network. The auth feature uses this so the
  /// boilerplate is runnable out of the box.
  static const bool useMockData = true;
}
