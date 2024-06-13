import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/about/data/data_sources/about_firebase_storage_remote_data_source.dart';
import 'package:fan2dev/features/about/domain/entities/about_images/about_images.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'about_cubit_state.dart';

class AboutCubit extends Cubit<AboutCubitState> {
  AboutCubit() : super(const AboutCubitState());

  Future<void> loadImages() async {
    emit(state.copyWith(status: AboutCubitStateStatus.loading));

    try {
      final result = await locator<AboutFirebaseStorageRemoteDataSource>()
          .getAboutImages();

      result.when(
        success: (aboutImages) {
          emit(
            state.copyWith(
              aboutImages: aboutImages,
              status: AboutCubitStateStatus.loaded,
            ),
          );
        },
        failure: (error) {
          l(
            'Error loading images: $error',
            exception: BusinessAppError.generic(
                errorCode: ErrorCodes.generic, errorMessage: error.toString(),),
            stackTrace: StackTrace.current,
            level: LogLevel.error,
            name: 'AboutCubit',
          );
          emit(
            state.copyWith(
              status: AboutCubitStateStatus.error,
              error: InternalAppError.generic(
                errorCode: ErrorCodes.generic,
                errorMessage: error.toString(),
              ),
            ),
          );
        },
        empty: () {
          l('No images found');
          emit(
            state.copyWith(
              status: AboutCubitStateStatus.error,
              error: const InternalAppError.generic(
                errorCode: ErrorCodes.generic,
                errorMessage: 'No images found.',
              ),
            ),
          );
        },
      );
    } catch (e) {
      l(
        'Error loading images: $e',
        exception: InternalAppError.generic(
          errorCode: ErrorCodes.generic,
          errorMessage: e.toString(),
        ),
        stackTrace: StackTrace.current,
        level: LogLevel.error,
        name: 'AboutCubit',
      );
      emit(
        state.copyWith(
          status: AboutCubitStateStatus.error,
          error: InternalAppError.generic(
            errorCode: ErrorCodes.generic,
            stackTrace: StackTrace.current,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}
