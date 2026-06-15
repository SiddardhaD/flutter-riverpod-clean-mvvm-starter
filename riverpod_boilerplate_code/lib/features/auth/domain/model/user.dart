import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Domain entity for an authenticated user.
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    @Default('') String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
