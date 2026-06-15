// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeControllerHash() => r'c0ff57e47904efa8c6b1d7194effe8b20b5376fb';

/// App theme mode (system / light / dark), persisted to [SharedPreferences].
///
/// Watch with `ref.watch(themeControllerProvider)` to drive
/// `MaterialApp.themeMode`. Toggle via the notifier's methods.
///
/// Copied from [ThemeController].
@ProviderFor(ThemeController)
final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeMode>.internal(
      ThemeController.new,
      name: r'themeControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeController = Notifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
