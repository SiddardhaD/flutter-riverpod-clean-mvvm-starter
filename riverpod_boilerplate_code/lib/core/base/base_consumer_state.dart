import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'responsive_builder_mixin.dart';

/// Base class for screen [State]s backed by Riverpod.
///
/// Extend this instead of `ConsumerState` to get:
///  - a per-widget [Logger] with lifecycle logging,
///  - the [ResponsiveBuilder] helpers (`isMobile`, `responsiveBuilder`, …).
///
///   `class _LoginScreenState extends BaseConsumerState<LoginScreen>`
abstract class BaseConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> with ResponsiveBuilder {
  Logger get log => Logger(T.toString());

  @override
  void initState() {
    super.initState();
    log.fine('$T initState');
  }

  @override
  void dispose() {
    log.fine('$T dispose');
    super.dispose();
  }
}
