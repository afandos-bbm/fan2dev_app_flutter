import 'package:dio/dio.dart';
import 'package:fan2dev/utils/extensions/string_extensions.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:flutter/foundation.dart';

/// Simple interceptor which logs all the dio response and error calls
/// Only will log the data when the app is built in debug and
/// the [_enableLogs] is true
class LoggerInterceptor extends Interceptor {
  /// Enables or disables the logger feature
  final bool _enableLogs = true;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode && _enableLogs) {
      logUpperLine();
      l('', name: '✅ onResponse');
      l(
        '${response.requestOptions.uri}',
        name: '🌐 url',
      );
      l('${response.statusCode}', name: '🤖 status');
      l(response.toString().getFirstCharacters, name: '📝 data');
      logBottomLine();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    final error = err;
    final stacktrace = err.stackTrace;

    if (kDebugMode && _enableLogs) {
      logUpperLine(level: LogLevel.error);
      l('', name: '❌ onError', level: LogLevel.error);
      if (response != null) {
        l(
          '${response.requestOptions.uri}',
          name: '🌐 url',
          level: LogLevel.error,
        );
        l('${response.statusCode}', name: '🤖 status', level: LogLevel.error);
      }

      l(
        '$response',
        error: error,
        stackTrace: stacktrace,
        name: '📝 response',
        level: LogLevel.error,
      );
      logBottomLine(level: LogLevel.error);
    }
    super.onError(err, handler);
  }
}
