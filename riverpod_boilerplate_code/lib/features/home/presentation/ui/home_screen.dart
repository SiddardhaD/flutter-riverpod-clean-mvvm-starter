import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base/base_consumer_state.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../view_model/home_view_model.dart';

/// Home screen shown to authenticated users. Demonstrates reading the session
/// ([AuthController]), local VM state (counter), and the theme toggle.
/// Logout flips the session, and the router redirects back to login.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(authControllerProvider.select((s) => s.user));
    final counter = ref.watch(homeViewModelProvider.select((s) => s.counter));
    final themeMode = ref.watch(themeControllerProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => ref.read(themeControllerProvider.notifier).toggle(),
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(homeViewModelProvider.notifier).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Signed in as', style: textTheme.labelSmall),
                    AppSpacing.gapXs,
                    Text(
                      user?.name.isNotEmpty == true ? user!.name : 'Guest',
                      style: textTheme.headlineMedium,
                    ),
                    if (user?.email != null) ...[
                      AppSpacing.gapXs,
                      Text(user!.email, style: textTheme.bodyMedium),
                    ],
                  ],
                ),
              ),
            ),
            AppSpacing.gapXl,
            Text('Counter demo', style: textTheme.headlineSmall),
            AppSpacing.gapSm,
            Text(
              'Notifier state updates — tap + to increment.',
              style: textTheme.bodyMedium,
            ),
            AppSpacing.gapLg,
            Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: AppRadius.brLg,
              ),
              alignment: Alignment.center,
              child: Text('$counter', style: textTheme.displayLarge),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(homeViewModelProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
