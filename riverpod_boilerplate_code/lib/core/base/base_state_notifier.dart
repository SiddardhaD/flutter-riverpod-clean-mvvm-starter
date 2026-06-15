import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Optional base for auto-dispose [Notifier]s that want a logger and a
/// clear `initialState()` seam.
///
/// Most view models in this project use the codegen `@riverpod` form
/// (extending the generated `_$X`). Use this only when you specifically
/// want the shared lifecycle logging without codegen.
abstract class BaseStateNotifier<T> extends AutoDisposeNotifier<T> {
  Logger get log => Logger(runtimeType.toString());

  @override
  T build() {
    log.fine('$runtimeType build');
    return initialState();
  }

  /// The state to start from.
  T initialState();
}
