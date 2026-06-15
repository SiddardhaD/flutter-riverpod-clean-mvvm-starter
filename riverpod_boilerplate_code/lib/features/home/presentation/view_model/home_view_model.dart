import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controller/auth_controller.dart';
import '../state/home_state.dart';

part 'home_view_model.g.dart';

/// View model for the home screen. Demonstrates local state mutation
/// (the counter) and delegating a session action to [AuthController].
@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() => const HomeState();

  void increment() {
    state = state.copyWith(counter: state.counter + 1);
  }

  Future<void> logout() {
    return ref.read(authControllerProvider.notifier).logout();
  }
}
