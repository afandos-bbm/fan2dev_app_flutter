import 'package:flutter/material.dart';

/// Enum that represents the available themes
enum CurrentTheme { light, dark }

/// Class whose purpose is to centralize, init and inject common themes.
final Map<CurrentTheme, ThemeData> themes = {
  CurrentTheme.light: _lightTheme,
  CurrentTheme.dark: _darkTheme,
};

/// Light theme
/// TODO: Add your custom light theme here
final ThemeData _lightTheme = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      minimumSize: const Size(0, 0),
    ),
  ),
);

/// Dark theme
/// TODO: Add your custom dark theme here
final ThemeData _darkTheme = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      minimumSize: const Size(0, 0),
    ),
  ),
);

extension ContextThemeExtension on BuildContext {
  ThemeData get currentTheme => Theme.of(this);
}
