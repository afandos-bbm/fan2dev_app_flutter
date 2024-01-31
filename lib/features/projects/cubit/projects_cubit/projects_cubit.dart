import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/projects/data/data_sources/projects_local_data_source.dart';
import 'package:fan2dev/features/projects/domain/project/projects_project.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'projects_cubit_state.dart';

class ProjectsCubit extends Cubit<ProjectsCubitState> {
  ProjectsCubit()
      : super(
          const ProjectsCubitState(),
        );

  Future<void> getProjects() async {
    emit(state.copyWith(status: ProjectsCubitStatus.loading));

    try {
      final result = locator<ProjectsLocalDataSource>().getProjects();
      result.when(
        success: (data) {
          emit(
            state.copyWith(
              status: ProjectsCubitStatus.loaded,
              projects: data,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copyWith(
              status: ProjectsCubitStatus.error,
              error: InternalAppError.generic(
                errorCode: ErrorCodes.generic,
                errorMessage: error.toString(),
              ),
            ),
          );
        },
        empty: () {
          emit(
            state.copyWith(
              status: ProjectsCubitStatus.error,
              error: const InternalAppError.generic(
                errorCode: ErrorCodes.generic,
                errorMessage: 'No projects found.',
              ),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProjectsCubitStatus.error,
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
