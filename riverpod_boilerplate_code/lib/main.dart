import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'app.dart';

void main() {
  // Route `package:logging` output to the console. Swap for Crashlytics /
  // Sentry wiring in a real app.
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.loggerName}: ${record.message}');
  });

  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const ProviderScope(child: App()));
    },
    (error, stack) => Logger('main').severe('Uncaught zone error', error, stack),
  );
}
