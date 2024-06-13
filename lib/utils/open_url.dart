import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> tryToOpenUrl(
  String url, {
  BuildContext? context,
}) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.inAppWebView);
  } on PlatformException catch (error) {
    l(
      ' ❌ launchUrl error: ',
      exception: InternalAppError.generic(
        errorCode: ErrorCodes.generic,
        errorMessage: error.toString(),
      ),
      name: 'tryToOpenUrl',
      level: LogLevel.error,
    );
  }
}
