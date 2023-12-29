import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fan2dev/utils/errors/error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension to get the [AppLocalizations] instance from the current context
extension AppLocalizationsX on BuildContext {
  /// Returns the [AppLocalizations] instance from the current context
  // TODO: Add more languages and translations on the arb files
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Function to translate the [ErrorCodes] to the corresponding error message
  /// from the [AppLocalizations]
  /// Example:
  /// ```dart
  /// context.translate(ErrorCodes.generic);
  /// ```
  /// will return the error message for the [ErrorCodes.generic] error code
  /// from the [AppLocalizations]
  /// If the error code is not found, it will return an empty string
  // TODO: Add more error codes
  String Function(ErrorCodes key) get translate => (key) {
        switch (key) {
          case ErrorCodes.generic:
            return l10n.error_generic;
        }
      };

  String Function(ThemeMode key) get translatedThemeMode => (key) {
        switch (key) {
          case ThemeMode.light:
            return l10n.settings_theme_light;
          case ThemeMode.dark:
            return l10n.settings_theme_dark;
          case ThemeMode.system:
            return l10n.settings_theme_system;
        }
      };

  String Function(String key) get translatedLanguage => (key) {
        switch (key) {
          case "es":
            return l10n.settings_language_es;
          case "va":
            return l10n.settings_language_va;
          case "en":
            return l10n.settings_language_en;
          default:
            return "";
        }
      };
}
