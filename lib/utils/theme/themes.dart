import 'package:flutter/material.dart';

/// Enum that represents the available themes
enum CurrentTheme { light, dark }

/// Class whose purpose is to centralize, init and inject common themes.
final Map<CurrentTheme, ThemeData> themes = {
  CurrentTheme.light: _lightTheme,
  CurrentTheme.dark: _darkTheme,
};

/// Light theme
final ThemeData _lightTheme = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Colors.cyan,
    secondary: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    floatingLabelStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      minimumSize: const Size(0, 0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(10),
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.white,
    ),
  ),
);

/// Dark theme
final ThemeData _darkTheme = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.cyan,
    secondary: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      minimumSize: const Size(0, 0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(10),
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.white,
    ),
  ),
);

extension ContextThemeExtension on BuildContext {
  ThemeData get currentTheme => Theme.of(this);
}
