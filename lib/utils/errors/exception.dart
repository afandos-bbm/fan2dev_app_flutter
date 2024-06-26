import 'package:fan2dev/utils/errors/error.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'exception.freezed.dart';

/// Base class for all exceptions in the application.
abstract class AppException implements Exception {
  const AppException({
    required this.errorCode,
    this.errorMessage = '',
  });

  final ErrorCodes errorCode;
  final String errorMessage;
}

/// Exceptions that are thrown by the business logic.
@freezed
class BusinessAppException extends AppException with _$BusinessAppException {
  const BusinessAppException._()
      : super(errorCode: ErrorCodes.generic, errorMessage: '');

  const factory BusinessAppException.generic({
    required ErrorCodes errorCode,
    @Default('No description provided') String errorMessage,
  }) = GenericAppException;

  const factory BusinessAppException.forbidden({
    required ErrorCodes errorCode,
    @Default('No description provided') String errorMessage,
  }) = ForbiddenAppException;
}

/// Exceptions that are thrown by the application itself.
@freezed
class InternalAppException extends AppException with _$InternalAppException {
  const InternalAppException._()
      : super(errorCode: ErrorCodes.generic, errorMessage: '');

  const factory InternalAppException.generic({
    required ErrorCodes errorCode,
    @Default('No description provided') String errorMessage,
  }) = GenericInternalAppException;

  /// Static factory constructor for [InternalAppException].
  /// Creates an InternalAppException.generic with the given [errorMessage].
  /// Also logs the error with the given [errorMessage] and the current
  /// stacktrace.
  factory InternalAppException.trace({
    StackTrace? stackTrace,
    String errorMessage = 'No description provided',
  }) {
    l(
      errorMessage,
      stackTrace: stackTrace ?? StackTrace.current,
      name: 'InternalAppException',
      level: LogLevel.error,
    );
    return InternalAppException.generic(
      errorCode: ErrorCodes.generic,
      errorMessage: errorMessage,
    );
  }
}
