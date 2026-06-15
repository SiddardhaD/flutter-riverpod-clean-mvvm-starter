import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/common/extension/validator_extension.dart';
import '../../../../core/exception/failure.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../model/user.dart';

part 'login_use_case.g.dart';

/// Business rule for signing in: validates input, then delegates to the
/// repository. Use cases keep view models thin and make the domain logic
/// independently testable.
class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<User, Failure>> call({
    required String email,
    required String password,
  }) async {
    if (!email.isValidEmail) {
      return const Error(Failure(message: 'Please enter a valid email.'));
    }
    if (!password.isValidPassword) {
      return const Error(
        Failure(message: 'Password must be at least 6 characters.'),
      );
    }
    return _repository.login(email: email.trim(), password: password);
  }
}

@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}
