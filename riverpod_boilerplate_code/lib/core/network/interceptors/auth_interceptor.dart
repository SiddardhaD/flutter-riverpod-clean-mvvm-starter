import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../local/secure_storage/token_storage.dart';

/// Set this in a request's `extra` to skip attaching the auth header
/// (e.g. for login / public endpoints):
///
///   dio.get(path, options: Options(extra: {skipAuthExtraKey: true}));
const String skipAuthExtraKey = 'skip_auth';

/// Attaches `Authorization: Bearer <token>` to outgoing requests and
/// (optionally) handles 401s. Token is read fresh from [TokenStorage] each
/// request so it always reflects the latest session.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref);

  final Ref _ref;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final skipAuth = options.extra[skipAuthExtraKey] == true;
    if (!skipAuth) {
      final token = await _ref.read(tokenStorageProvider).readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Session expired — clear tokens. A real app would also trigger a
      // refresh-token flow and/or redirect to login here.
      await _ref.read(tokenStorageProvider).clear();
    }
    handler.next(err);
  }
}
