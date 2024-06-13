import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/firebase_options.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Bootstraps the application with the given [builder].
// Add cross-flavor configuration here
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  /// Initializes the logger.
  initLogger();

  /// Logs all Flutter errors to the console.
  FlutterError.onError = (details) {
    l(
      details.exceptionAsString(),
      stackTrace: details.stack,
      level: LogLevel.error,
      name: '❌ FlutterError',
    );
  };

  /// Shows a custom error widget instead of the default Flutter error widget.
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    l(
      errorDetails.exceptionAsString(),
      stackTrace: errorDetails.stack,
      level: LogLevel.error,
      name: '❌ ErrorWidget',
    );
    return ColoredBox(
      color: Colors.red,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'An error has occurred.',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                errorDetails.exceptionAsString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  };

  /// Initializes the Widgets library for the application. (prevent errors)
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializes the bloc logger.
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printCreations: true,
      printClosings: true,
      printChanges: true,
    ),
  );

  /// Initializes the service locator.
  await initGetIt();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  /// Initializes the URL strategy for the web.
  usePathUrlStrategy();

  final deviceInfo = await DeviceInfo().getDeviceInfoPerPlatform();
  if (deviceInfo != null) {
    Sentry.metrics().increment(
      'app.start',
      unit: SentryMeasurementUnit.none,
      tags: {'device-info': deviceInfo.toString()},
    );
  }

  /// Runs the application.
  runApp(await builder());
}
