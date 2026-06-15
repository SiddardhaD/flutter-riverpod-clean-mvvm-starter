import 'package:flutter/material.dart';

import 'break_point.dart';

/// Mix into a [State] / [ConsumerState] to branch layout by screen width.
///
///   @override
///   Widget build(BuildContext context) => responsiveBuilder(
///         context: context,
///         mobile: _MobileLayout(),
///         tablet: _TabletLayout(),
///         desktop: _DesktopLayout(),
///       );
mixin ResponsiveBuilder {
  Widget responsiveBuilder({
    required BuildContext context,
    Widget? mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width >= BreakPoint.desktop) {
      return desktop ?? tablet ?? mobile ?? const SizedBox.shrink();
    }
    if (width >= BreakPoint.tablet) {
      return tablet ?? mobile ?? const SizedBox.shrink();
    }
    return mobile ?? const SizedBox.shrink();
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < BreakPoint.tablet;

  bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= BreakPoint.tablet && width < BreakPoint.desktop;
  }

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= BreakPoint.desktop;
}
