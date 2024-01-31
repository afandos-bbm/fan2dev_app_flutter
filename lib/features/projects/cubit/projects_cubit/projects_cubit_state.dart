part of 'projects_cubit.dart';

enum ProjectsCubitStatus { initial, loading, loaded, error }

class ProjectsCubitState extends Equatable {
  const ProjectsCubitState(
      {this.status = ProjectsCubitStatus.initial,
      this.projects = const <ProjectsProject>[],
      this.error});

  final ProjectsCubitStatus status;
  final List<ProjectsProject> projects;
  final AppError? error;

  ProjectsCubitState copyWith({
    ProjectsCubitStatus? status,
    List<ProjectsProject>? projects,
    AppError? error,
  }) {
    return ProjectsCubitState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, projects, error];
}
