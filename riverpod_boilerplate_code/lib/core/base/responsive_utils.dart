import 'package:flutter/material.dart';

/// Scales sizes relative to a reference design device, so values pulled
/// straight from Figma render proportionally across screen sizes.
///
/// Reference device: iPhone 16 (402 × 874 logical px). Override [baseWidth]
/// / [baseHeight] if your designs target a different frame.
///
/// Prefer the [ResponsiveUtilsExtension] shorthands in widgets:
///   width: context.rw(120),
///   padding: EdgeInsets.all(context.rp(16)),
class ResponsiveUtils {
  ResponsiveUtils._();

  static const double baseWidth = 402;
  static const double baseHeight = 874;

  static double w(BuildContext context, double width) =>
      (width / baseWidth) * MediaQuery.of(context).size.width;

  static double h(BuildContext context, double height) =>
      (height / baseHeight) * MediaQuery.of(context).size.height;

  /// Font size scaled by width (keeps text proportional to layout, not
  /// to device height which varies with notches/safe-areas).
  static double f(BuildContext context, double fontSize) =>
      (fontSize / baseWidth) * MediaQuery.of(context).size.width;

  static double r(BuildContext context, double radius) =>
      (radius / baseWidth) * MediaQuery.of(context).size.width;

  static double p(BuildContext context, double value) =>
      (value / baseWidth) * MediaQuery.of(context).size.width;

  static bool isSmallDevice(BuildContext context) =>
      MediaQuery.of(context).size.height < 700;

  static bool isLargeDevice(BuildContext context) =>
      MediaQuery.of(context).size.height > 900;
}

extension ResponsiveUtilsExtension on BuildContext {
  double rw(double width) => ResponsiveUtils.w(this, width);
  double rh(double height) => ResponsiveUtils.h(this, height);
  double rf(double fontSize) => ResponsiveUtils.f(this, fontSize);
  double rr(double radius) => ResponsiveUtils.r(this, radius);
  double rp(double value) => ResponsiveUtils.p(this, value);

  Size get screenSize => MediaQuery.of(this).size;
}
