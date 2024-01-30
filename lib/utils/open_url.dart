import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> tryToOpenUrl(
  String url, {
  BuildContext? context,
}) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.inAppWebView);
  } on PlatformException catch (error) {
    log(' ❌ launchUrl error: ', error: error);
  }
}
