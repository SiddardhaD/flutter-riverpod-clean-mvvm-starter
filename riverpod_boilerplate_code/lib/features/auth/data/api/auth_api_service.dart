import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../dto/login_request.dart';
import '../dto/login_response.dart';

part 'auth_api_service.g.dart';

/// Retrofit definition of the auth endpoints.
///
/// The sample [AuthRepositoryImpl] mocks responses (see [AppConfig.useMockData]),
/// so this isn't actually hit at runtime — it's here to show the canonical
/// Retrofit + Dio wiring you'd use against a real backend.
@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('v1/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('v1/auth/logout')
  Future<void> logout();
}

@Riverpod(keepAlive: true)
AuthApiService authApiService(Ref ref) {
  return AuthApiService(ref.watch(dioProvider));
}
