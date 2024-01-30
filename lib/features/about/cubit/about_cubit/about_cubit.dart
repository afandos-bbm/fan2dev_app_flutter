import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/about/data/data_sources/about_firebase_storage_remote_data_source.dart';
import 'package:fan2dev/features/about/domain/entities/about_images/about_images.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          l('Error loading images: $error');
          emit(
            state.copyWith(
              status: AboutCubitStateStatus.error,
              error: error,
            ),
          );
        },
        empty: () {
          l('No images found');
          emit(
            state.copyWith(
              status: AboutCubitStateStatus.error,
              error: Exception('No images found'),
            ),
          );
        },
      );
    } catch (e) {
      l('Error loading images: $e');
      emit(
        state.copyWith(
          status: AboutCubitStateStatus.error,
          error: Exception('Error loading images'),
        ),
      );
    }
  }
}
