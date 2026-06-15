import 'package:flutter/material.dart';

/// Design-system color tokens.
///
/// Pure constants — no Flutter context required. Light/dark variants are
/// suffixed `Light` / `Dark`. Resolve the right one through [AppTheme]
/// (which wires these into [ColorScheme]) rather than reading them directly
/// in widgets, so theming stays centralized.
class AppColors {
  AppColors._();

  // ── Brand / Accent ──────────────────────────────────────────────
  static const Color primary = Color(0xFF1E6EF4);
  static const Color primaryDark = Color(0xFF5CB8FF);
  static const Color secondary = Color(0xFF6155F5);
  static const Color secondaryDark = Color(0xFFA7AAFF);

  // ── Backgrounds ─────────────────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF2F2F7);
  static const Color backgroundDark = Color(0xFF000000);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1C1C1E);

  static const Color surfaceElevatedLight = Color(0xFFFFFFFF);
  static const Color surfaceElevatedDark = Color(0xFF2C2C2E);

  // ── Labels / Text ───────────────────────────────────────────────
  static const Color labelPrimaryLight = Color(0xFF000000);
  static const Color labelPrimaryDark = Color(0xFFFFFFFF);

  static const Color labelSecondaryLight = Color(0x993C3C43); // 60%
  static const Color labelSecondaryDark = Color(0x99EBEBF5); // 60%

  static const Color labelTertiaryLight = Color(0x4D3C3C43); // 30%
  static const Color labelTertiaryDark = Color(0x4DEBEBF5); // 30%

  // ── Borders / Separators ────────────────────────────────────────
  static const Color separatorLight = Color(0xFFC6C6C8);
  static const Color separatorDark = Color(0xFF38383A);

  static const Color borderLight = Color(0x1F000000); // 12%
  static const Color borderDark = Color(0x2BFFFFFF); // 17%

  // ── Fills (input fields, chips) ─────────────────────────────────
  static const Color fillLight = Color(0x1F767680); // 12%
  static const Color fillDark = Color(0x33767680); // 20%

  // ── Semantic ────────────────────────────────────────────────────
  static const Color success = Color(0xFF34C759);
  static const Color successDark = Color(0xFF30D158);

  static const Color warning = Color(0xFFFFCC00);
  static const Color warningDark = Color(0xFFFFD600);

  static const Color error = Color(0xFFE9152D);
  static const Color errorDark = Color(0xFFFF6165);

  static const Color info = Color(0xFF0091FF);

  // ── Neutrals ────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  static const Color gray1 = Color(0xFF8E8E93);
  static const Color gray2 = Color(0xFFAEAEB2);
  static const Color gray3 = Color(0xFFC7C7CC);
  static const Color gray4 = Color(0xFFD1D1D6);
  static const Color gray5 = Color(0xFFE5E5EA);
  static const Color gray6 = Color(0xFFF2F2F7);

  /// Disabled / muted control color.
  static const Color disabled = Color(0xFFB0B0B5);
}
