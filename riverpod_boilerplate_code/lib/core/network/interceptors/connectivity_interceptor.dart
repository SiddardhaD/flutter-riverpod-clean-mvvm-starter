import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

/// Fails fast with a [DioException] of type [DioExceptionType.connectionError]
/// when the device is offline, so the UI can show an offline state without
/// waiting for a socket timeout.
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final results = await _connectivity.checkConnectivity();
    final isOffline =
        results.isEmpty || results.every((r) => r == ConnectivityResult.none);
    if (isOffline) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection.',
        ),
      );
    }
    handler.next(options);
  }
}
