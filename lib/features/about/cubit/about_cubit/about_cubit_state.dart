part of 'about_cubit.dart';

enum AboutCubitStateStatus { initial, loading, loaded, error }

class AboutCubitState extends Equatable {
  const AboutCubitState({
    this.status = AboutCubitStateStatus.initial,
    this.aboutImages,
    this.error,
  });

  final AboutCubitStateStatus status;
  final AboutImages? aboutImages;
  final Exception? error;

  AboutCubitState copyWith({
    AboutCubitStateStatus? status,
    AboutImages? aboutImages,
    Exception? error,
  }) {
    return AboutCubitState(
      aboutImages: aboutImages ?? this.aboutImages,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, aboutImages, error];
}
