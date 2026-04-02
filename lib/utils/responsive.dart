import 'package:flutter/material.dart';

/// Responsive breakpoints and utility helpers for the Sanwariya app.
class Responsive {
  // Breakpoints
  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  static bool isTabletOrDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMax;

  /// Returns a value based on current breakpoint.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax && desktop != null) return desktop;
    if (w >= mobileMax && tablet != null) return tablet;
    return mobile;
  }

  /// Horizontal content padding — narrows on mobile, wider on larger screens.
  static EdgeInsets horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return const EdgeInsets.symmetric(horizontal: 80);
    if (w >= mobileMax) return const EdgeInsets.symmetric(horizontal: 48);
    return const EdgeInsets.symmetric(horizontal: 24);
  }

  /// Max-width constraint for desktop content blocks.
  static double maxContentWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return 1200;
    return double.infinity;
  }

  /// Grid cross-axis count for product grids.
  static int gridCrossAxisCount(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return 4;
    if (w >= mobileMax) return 3;
    return 2;
  }

  /// Hero section height — taller on desktop.
  static double heroHeight(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return 700;
    if (w >= mobileMax) return 620;
    return 520;
  }

  /// Display title font size.
  static double displayFontSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return 64;
    if (w >= mobileMax) return 52;
    return 40;
  }

  /// Whether to show a bottom nav bar (hidden on desktop in favor of top nav).
  static bool showBottomNav(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletMax;

  /// Whether to show full top navigation (desktop).
  static bool showTopNav(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;
}
