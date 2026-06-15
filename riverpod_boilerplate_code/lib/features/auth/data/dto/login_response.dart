import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/user.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

/// Wire model for a successful login response.
@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    required User user,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
