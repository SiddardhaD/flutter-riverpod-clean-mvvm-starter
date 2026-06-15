import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exception/failure.dart';
import '../../domain/model/user.dart';

/// Contract for the auth data source. The domain/use-case layer depends on
/// this abstraction, not on the concrete [AuthRepositoryImpl], so the data
/// source can be swapped (real API, mock, fake in tests) without touching
/// business logic.
abstract interface class AuthRepository {
  Future<Result<User, Failure>> login({
    required String email,
    required String password,
  });

  Future<Result<void, Failure>> logout();
}
