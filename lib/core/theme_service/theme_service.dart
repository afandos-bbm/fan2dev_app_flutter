import 'package:flutter/material.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/scheduler.dart';

/// Utility service which interacts with ThemeMode
///
/// Example of how to toggle the theme:
/// ```
/// final themeService = locator<ThemeService>();
/// themeService.toggleTheme();
/// ```
class ThemeService extends ChangeNotifier {
  ThemeService() {
    final themeModeString = locator<SharedPreferencesService>().themeMode;
    final themeMode = _parseThemeMode(themeModeString);
    _themeMode = themeMode;

    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode {
    if (_themeMode == ThemeMode.system) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }

    return _themeMode;
  }

  ThemeMode get realThemeMode => _themeMode;

  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isDarkMode => !isLightMode;

  ThemeData? get themeData =>
      isLightMode ? themes[CurrentTheme.light] : themes[CurrentTheme.dark];

  /// Toggles the current theme mode
  /// and saves the new theme mode to shared preferences
  /// using [SharedPreferencesService]
  /// and notifies all the listeners.
  void changeThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveThemeMode();
    notifyListeners();
  }

  void _saveThemeMode() =>
      locator<SharedPreferencesService>().themeMode = _themeMode.toString();

  ThemeMode _parseThemeMode(String themeModeString) {
    switch (themeModeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}
