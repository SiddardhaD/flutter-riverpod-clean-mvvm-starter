import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/exception/failure.dart';
import '../../../../core/local/secure_storage/token_storage.dart';
import '../../domain/model/user.dart';
import '../api/auth_api_service.dart';
import '../dto/login_request.dart';
import 'auth_repository.dart';

part 'auth_repository_impl.g.dart';

/// Concrete [AuthRepository].
///
/// When [AppConfig.useMockData] is true (the default for this boilerplate) it
/// returns a simulated response so the app runs without a backend. Otherwise
/// it calls the real [AuthApiService]. Either way it normalizes errors into a
/// [Failure] and persists tokens via [TokenStorage].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api, this._tokenStorage);

  final AuthApiService _api;
  final TokenStorage _tokenStorage;

  @override
  Future<Result<User, Failure>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (AppConfig.useMockData) {
        return _mockLogin(email: email, password: password);
      }

      final response = await _api.login(
        LoginRequest(email: email, password: password),
      );
      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return Success(response.user);
    } on DioException catch (e, st) {
      return Error(_mapDioError(e, st));
    } catch (e, st) {
      return Error(Failure(message: e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Result<void, Failure>> logout() async {
    try {
      if (!AppConfig.useMockData) {
        await _api.logout();
      }
      await _tokenStorage.clear();
      return const Success(null);
    } on DioException catch (e, st) {
      // Even if the network logout fails, drop local tokens.
      await _tokenStorage.clear();
      return Error(_mapDioError(e, st));
    }
  }

  // ── Mock ──────────────────────────────────────────────────────────
  Future<Result<User, Failure>> _mockLogin({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Demo rule: any valid-looking email + password >= 6 chars succeeds,
    // except a reserved address that always fails (to exercise error UI).
    if (email.toLowerCase() == 'fail@example.com') {
      return const Error(
        Failure(code: 'INVALID_CREDENTIALS', message: 'Invalid email or password.'),
      );
    }

    await _tokenStorage.saveTokens(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
    );
    final name = email.split('@').first;
    return Success(
      User(id: 'mock-user-id', email: email, name: name),
    );
  }

  Failure _mapDioError(DioException e, StackTrace st) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const Failure.network();
    }
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final message = (data is Map && data['message'] is String)
        ? data['message'] as String
        : 'Request failed${status != null ? ' ($status)' : ''}.';
    return Failure(
      message: message,
      statusCode: status,
      code: (data is Map && data['code'] is String) ? data['code'] as String : null,
      stackTrace: st,
    );
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    ref.watch(authApiServiceProvider),
    ref.watch(tokenStorageProvider),
  );
}
