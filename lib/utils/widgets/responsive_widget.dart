import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  /// Creates a widget that builds differently depending on the screen size.
  /// The [mobile], [tablet], and [desktop] arguments
  /// [mobile] and [desktop] must not be null.
  /// If [tablet] is null, then [mobile] is used in its place.
  const ResponsiveWidget({
    required this.mobile,
    required this.desktop,
    this.tablet,
    super.key,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
      MediaQuery.of(context).size.width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1200) {
          return tablet ?? mobile;
        } else {
          return desktop;
        }
      },
    );
  }
}
