import 'package:flutter/material.dart';

/// Enum that represents the available themes
enum CurrentTheme { light, dark, system }

/// Class whose purpose is to centralize, init and inject common themes.
final Map<CurrentTheme, ThemeData> themes = {
  CurrentTheme.light: _lightTheme,
  CurrentTheme.dark: _darkTheme,
};

const kPrimaryColor = Colors.cyan;

// Info
const kInfoSwatch = MaterialColor(
  0xFF006FB4,
  <int, Color>{
    120: Color(0xFF005990),
    110: Color(0xFF0064A2),
    100: Color(0xFF006FB4),
    50: Color(0xFF80B7DA),
    25: Color(0xFFBFDBEC),
  },
);

// Success
const kSuccessSwatch = MaterialColor(
  0xFF467A39,
  <int, Color>{
    120: Color(0xFF38622E),
    110: Color(0xFF3F6E33),
    100: Color(0xFF467A39),
    50: Color(0xFFA3BD9C),
    25: Color(0xFFD1DECD),
  },
);

// Warning
const kWarningSwatch = MaterialColor(
  0xFFF29527,
  <int, Color>{
    140: Color(0xFF915917),
    120: Color(0xFFC2771F),
    110: Color(0xFFDA8623),
    100: Color(0xFFF29527),
    50: Color(0xFFF9CA93),
    25: Color(0xFFFCE5C9),
  },
);

// Danger
const kDangerSwatch = MaterialColor(
  0xFFDA2131,
  <int, Color>{
    120: Color(0xFFAE1A27),
    110: Color(0xFFC41E2C),
    100: Color(0xFFDA2131),
    50: Color(0xFFED9098),
    25: Color(0xFFF6C8CC),
  },
);

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
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
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
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.white,
    disabledColor: Colors.grey,
    selectedColor: kPrimaryColor,
    secondarySelectedColor: Colors.grey,
    padding: EdgeInsets.all(2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      side: BorderSide(color: Colors.black26),
    ),
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    secondaryLabelStyle: TextStyle(
      color: Colors.white,
    ),
    brightness: Brightness.light,
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
    focusedBorder: OutlineInputBorder(),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
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
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.grey,
    disabledColor: Colors.grey,
    selectedColor: kPrimaryColor,
    secondarySelectedColor: Colors.grey,
    padding: EdgeInsets.all(2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      side: BorderSide(color: Colors.black26),
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    secondaryLabelStyle: TextStyle(
      color: Colors.white,
    ),
    brightness: Brightness.dark,
  ),
);

extension ContextThemeExtension on BuildContext {
  ThemeData get currentTheme => Theme.of(this);
  ColorScheme get themeColors => Theme.of(this).colorScheme;
}
