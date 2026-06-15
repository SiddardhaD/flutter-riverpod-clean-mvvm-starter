import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

/// UI state for the home screen.
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(0) int counter,
  }) = _HomeState;
}
