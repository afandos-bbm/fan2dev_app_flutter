import 'package:flutter/material.dart';

/// Enum that represents the available themes
enum CurrentTheme { light, dark, system }

/// Class whose purpose is to centralize, init and inject common themes.
final Map<CurrentTheme, ThemeData> themes = {
  CurrentTheme.light: _lightTheme,
  CurrentTheme.dark: _darkTheme,
};

const kPrimaryColor = Colors.cyan;

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
    primary: kPrimaryColor,
    secondary: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
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
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 12,
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
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),
  ),
  cardTheme: const CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    color: Colors.white,
    surfaceTintColor: Colors.white,
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
    primary: kPrimaryColor,
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
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    color: Colors.grey[900],
    surfaceTintColor: Colors.grey[900],
  ),
);

extension ContextThemeExtension on BuildContext {
  ThemeData get currentTheme => Theme.of(this);
}
