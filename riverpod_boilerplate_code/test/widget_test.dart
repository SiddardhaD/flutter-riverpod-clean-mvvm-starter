// Unit tests for the auth slice. These exercise pure domain logic (no
// platform channels), showing how the Clean Architecture layering keeps
// business rules testable in isolation.

import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_boilerplate_code/core/common/extension/validator_extension.dart';
import 'package:riverpod_boilerplate_code/core/exception/failure.dart';
import 'package:riverpod_boilerplate_code/features/auth/data/repository/auth_repository.dart';
import 'package:riverpod_boilerplate_code/features/auth/domain/model/user.dart';
import 'package:riverpod_boilerplate_code/features/auth/domain/use_case/login_use_case.dart';

/// In-memory fake standing in for the real data source.
class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({this.shouldSucceed = true});

  final bool shouldSucceed;
  int loginCalls = 0;

  @override
  Future<Result<User, Failure>> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    if (!shouldSucceed) {
      return const Error(Failure(message: 'bad creds'));
    }
    return Success(User(id: '1', email: email, name: 'Test'));
  }

  @override
  Future<Result<void, Failure>> logout() async => const Success(null);
}

void main() {
  group('ValidatorExtension', () {
    test('accepts well-formed email', () {
      expect('user@example.com'.isValidEmail, isTrue);
      expect('not-an-email'.isValidEmail, isFalse);
    });

    test('password requires 6+ chars', () {
      expect('123456'.isValidPassword, isTrue);
      expect('12345'.isValidPassword, isFalse);
    });
  });

  group('LoginUseCase', () {
    test('rejects invalid email before hitting the repository', () async {
      final repo = _FakeAuthRepository();
      final useCase = LoginUseCase(repo);

      final result =
          await useCase(email: 'bad', password: 'password123');

      expect(result.isError(), isTrue);
      expect(repo.loginCalls, 0);
    });

    test('returns the user on valid credentials', () async {
      final repo = _FakeAuthRepository();
      final useCase = LoginUseCase(repo);

      final result =
          await useCase(email: 'user@example.com', password: 'password123');

      expect(result.isSuccess(), isTrue);
      expect(result.tryGetSuccess()?.email, 'user@example.com');
      expect(repo.loginCalls, 1);
    });

    test('propagates repository failure', () async {
      final repo = _FakeAuthRepository(shouldSucceed: false);
      final useCase = LoginUseCase(repo);

      final result =
          await useCase(email: 'user@example.com', password: 'password123');

      expect(result.isError(), isTrue);
    });
  });
}
