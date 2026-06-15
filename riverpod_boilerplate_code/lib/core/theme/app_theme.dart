import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

/// Builds the light and dark [ThemeData] from the design tokens.
///
/// Widgets should read colors/text via `Theme.of(context)` (e.g.
/// `theme.colorScheme.primary`, `theme.textTheme.bodyMedium`) so switching
/// brightness flows everywhere automatically.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? AppColors.primaryDark : AppColors.primary,
      onPrimary: AppColors.white,
      secondary: isDark ? AppColors.secondaryDark : AppColors.secondary,
      onSecondary: AppColors.white,
      error: isDark ? AppColors.errorDark : AppColors.error,
      onError: AppColors.white,
      surface: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      onSurface: isDark ? AppColors.labelPrimaryDark : AppColors.labelPrimaryLight,
      outline: isDark ? AppColors.separatorDark : AppColors.separatorLight,
    );

    final textColor =
        isDark ? AppColors.labelPrimaryDark : AppColors.labelPrimaryLight;
    final secondaryTextColor =
        isDark ? AppColors.labelSecondaryDark : AppColors.labelSecondaryLight;

    final textTheme = TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: textColor),
      headlineLarge: AppTextStyles.headingLarge.copyWith(color: textColor),
      headlineMedium: AppTextStyles.headingMedium.copyWith(color: textColor),
      headlineSmall: AppTextStyles.headingSmall.copyWith(color: textColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: secondaryTextColor),
      labelLarge: AppTextStyles.button.copyWith(color: AppColors.white),
      labelMedium: AppTextStyles.label.copyWith(color: textColor),
      labelSmall: AppTextStyles.caption.copyWith(color: secondaryTextColor),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.headingSmall.copyWith(color: textColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: AppColors.disabled,
          minimumSize: const Size.fromHeight(52),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.brMd),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size.fromHeight(52),
          textStyle: AppTextStyles.button,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.brMd),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: AppTextStyles.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.fillDark : AppColors.fillLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: secondaryTextColor),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        color: isDark ? AppColors.surfaceElevatedDark : AppColors.surfaceElevatedLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.brLg),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline,
        thickness: 0.5,
        space: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
