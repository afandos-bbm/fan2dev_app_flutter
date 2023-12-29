import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// A  generic result type that represents either a success or a failure.
@freezed
sealed class Result<T, E> with _$Result<T, E> {
  const Result._();

  /// Failure result with an error of type [E]
  const factory Result.failure({required E error}) = Failure<T, E>;

  /// Success result with data of type [T]
  const factory Result.success({required T data}) = Success<T, E>;

  /// Success result with empty data
  const factory Result.empty() = Empty<T, E>;

  bool get isSuccess =>
      when(failure: (_) => false, success: (_) => true, empty: () => true);
  bool get isFailure => !isSuccess;
}

class EmptySuccess {}
