import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'projects_project.g.dart';

enum ProjectsProjectStatus { soon, development, finished }

@JsonSerializable()
class ProjectsProject extends Equatable {
  const ProjectsProject({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.estimatedDuration,
    required this.logoAssetUrl,
    required this.screenShotAssetUrl,
    this.codeRepositoryUrl,
    this.webPageUrl,
  });

  factory ProjectsProject.fromJson(Map<String, dynamic> json) =>
      _$ProjectsProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsProjectToJson(this);

  final int id;
  final String name;
  final String description;
  final ProjectsProjectStatus status;
  final String estimatedDuration;
  final String logoAssetUrl;
  final String screenShotAssetUrl;
  final String? codeRepositoryUrl;
  final String? webPageUrl;

  ProjectsProject copyWith({
    String? name,
    String? description,
    ProjectsProjectStatus? status,
    String? estimatedTimeExpended,
    String? logoAssetUrl,
    String? screenShotAssetUrl,
    String? codeRepositoryUrl,
    String? webPageUrl,
  }) {
    return ProjectsProject(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      estimatedDuration: estimatedTimeExpended ?? this.estimatedDuration,
      logoAssetUrl: logoAssetUrl ?? this.logoAssetUrl,
      screenShotAssetUrl: screenShotAssetUrl ?? this.screenShotAssetUrl,
      codeRepositoryUrl: codeRepositoryUrl ?? this.codeRepositoryUrl,
      webPageUrl: webPageUrl ?? this.webPageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        status,
        estimatedDuration,
        logoAssetUrl,
        screenShotAssetUrl,
        codeRepositoryUrl,
        webPageUrl,
      ];
}
