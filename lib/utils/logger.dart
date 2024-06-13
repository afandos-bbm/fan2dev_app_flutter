import 'dart:developer';

import 'package:fan2dev/core/configuration_service/configuration_service.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

late Talker talker;

/// Logger wrapper for the [log] function.
/// Logs the given [message] to the console.
/// Optionally, a [level] can be provided to color the message.
/// Optionally, a [name] can be provided to identify the log message.
/// Optionally, an [exception] can be provided to log an error message.
/// Optionally, a [stackTrace] can be provided to log a stacktrace.
void l(
  String message, {
  LogLevel level = LogLevel.info,
  String? name,
  Object? exception,
  StackTrace? stackTrace,
}) {
  final loggerTitle =
      name != null ? '${_getLevelTitle(level)} - $name' : _getLevelTitle(level);

  if (!kDebugMode && (level == LogLevel.debug || level == LogLevel.verbose)) {
    return;
  }

  talker.logTyped(
    TalkerLog(
      message,
      logLevel: level,
      title: loggerTitle,
      stackTrace: stackTrace,
      exception: exception,
      time: DateTime.now().toUtc(),
    ),
  );

  if (kDebugMode) {
    return;
  }

  if (level == LogLevel.error || level == LogLevel.critical) {
    Sentry.captureMessage(
      message,
      level: _getSentryLevel(level),
      withScope: (scope) {
        scope.setExtra('exception', exception);
        scope.setExtra('stackTrace', stackTrace);
        scope.addBreadcrumb(
          Breadcrumb(
            message: message,
            category: loggerTitle,
          ),
        );
      },
    );
  }
}

void initLogger() {
  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      titles: _loggerTitles,
      enabled: !ConfigurationService.i.currentFlavor.isProduction,
    ),
  );
}

final _loggerTitles = {
  TalkerLogType.info: 'ℹ️ Info',
  TalkerLogType.debug: '🐛 Debug',
  TalkerLogType.error: '❌ Error',
  TalkerLogType.warning: '⚠️ Warning',
  TalkerLogType.critical: '🚨 Critical',
  TalkerLogType.exception: '🔥 Exception',
  TalkerLogType.route: '🚦 Route',
  TalkerLogType.httpError: '❌ HTTP Error',
  TalkerLogType.httpRequest: '🌐 HTTP Request',
  TalkerLogType.httpResponse: '✅ HTTP Response',
  TalkerLogType.blocCreate: '🧱 Bloc Create',
  TalkerLogType.blocClose: '🔨 Bloc Close',
  TalkerLogType.blocTransition: '🔄 Bloc Transition',
  TalkerLogType.blocEvent: '📦 Bloc Event',
};

String _getLevelTitle(LogLevel level) {
  switch (level) {
    case LogLevel.info:
      return 'ℹ️ Info';
    case LogLevel.debug:
      return '🐛 Debug';
    case LogLevel.error:
      return '❌ Error';
    case LogLevel.warning:
      return '⚠️ Warning';
    case LogLevel.critical:
      return '🚨 Critical';
    case LogLevel.verbose:
      return '🔍 Verbose';
  }
}

SentryLevel _getSentryLevel(LogLevel level) {
  switch (level) {
    case LogLevel.info:
      return SentryLevel.info;
    case LogLevel.debug:
      return SentryLevel.debug;
    case LogLevel.error:
      return SentryLevel.error;
    case LogLevel.warning:
      return SentryLevel.warning;
    case LogLevel.critical:
      return SentryLevel.fatal;
    case LogLevel.verbose:
      return SentryLevel.debug;
  }
}
