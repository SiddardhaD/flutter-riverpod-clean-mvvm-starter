import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography scale.
///
/// Styles are color-agnostic — color is applied by [AppTheme] via the
/// [TextTheme] / `copyWith`, so the same style works in light and dark mode.
/// Font family is Inter (swap in [_font] to rebrand everywhere at once).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _font({
    required double size,
    required FontWeight weight,
    double height = 1.3,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ── Display / Headings ──────────────────────────────────────────
  static TextStyle get displayLarge =>
      _font(size: 32, weight: FontWeight.w700, height: 1.2, letterSpacing: -0.5);

  static TextStyle get headingLarge =>
      _font(size: 28, weight: FontWeight.w700, height: 1.2, letterSpacing: -0.4);

  static TextStyle get headingMedium =>
      _font(size: 22, weight: FontWeight.w600, height: 1.25);

  static TextStyle get headingSmall =>
      _font(size: 18, weight: FontWeight.w600, height: 1.3);

  // ── Body ────────────────────────────────────────────────────────
  static TextStyle get bodyLarge =>
      _font(size: 17, weight: FontWeight.w400, height: 1.4);

  static TextStyle get bodyMedium =>
      _font(size: 15, weight: FontWeight.w400, height: 1.4);

  static TextStyle get bodySmall =>
      _font(size: 13, weight: FontWeight.w400, height: 1.4);

  // ── Labels / Buttons ────────────────────────────────────────────
  static TextStyle get button =>
      _font(size: 16, weight: FontWeight.w600, height: 1.2);

  static TextStyle get label =>
      _font(size: 14, weight: FontWeight.w500, height: 1.3);

  static TextStyle get caption =>
      _font(size: 12, weight: FontWeight.w400, height: 1.3);
}
