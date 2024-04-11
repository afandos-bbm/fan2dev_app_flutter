import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Gets the privacy policy text based on the current locale
Future<String> loadPrivacyPolicy(BuildContext context) async {
  Localizations.localeOf(context).languageCode;
  switch (Localizations.localeOf(context).languageCode) {
    case 'ca':
      return rootBundle.loadString('assets/texts/privacy_policy_ca.txt');
    case 'en':
      return rootBundle.loadString('assets/texts/privacy_policy_es.txt');
    case 'es':
    default:
      return rootBundle.loadString('assets/texts/privacy_policy_es.txt');
  }
}
