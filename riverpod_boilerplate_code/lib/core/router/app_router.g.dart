// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'fd1b660d0e8f2dbe2f821474c7125357b438ec82';

/// The app [GoRouter].
///
/// Auth gating lives in [redirect], driven by [AuthController]:
///  - while the session is restoring ([AuthStatus.unknown]) → splash,
///  - authenticated users are kept out of `/login`,
///  - unauthenticated users are bounced to `/login`.
///
/// A [ValueNotifier] bridges the auth state into GoRouter's
/// `refreshListenable` so redirects re-run whenever the session changes.
///
/// Copied from [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<GoRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
