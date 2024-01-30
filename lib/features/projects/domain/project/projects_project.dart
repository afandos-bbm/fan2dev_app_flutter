import 'package:equatable/equatable.dart';
import 'package:fan2dev/features/projects/domain/technology/projects_project_technology.dart';
import 'package:json_annotation/json_annotation.dart';

part 'projects_project.g.dart';

enum ProjectsProjectStatus { soon, development, finished }

@JsonSerializable()
class ProjectsProject extends Equatable {
  const ProjectsProject({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.status,
    required this.estimatedTimeExpended,
    required this.technologies,
    required this.logoAssetUrl,
    required this.screenShotAssetUrls,
    this.codeRepositoryUrl,
    this.webPageUrl,
  });

  factory ProjectsProject.fromJson(Map<String, dynamic> json) =>
      _$ProjectsProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsProjectToJson(this);

  final int id;
  final String name;
  final String description;
  final String longDescription;
  final ProjectsProjectStatus status;
  final String estimatedTimeExpended;
  final List<ProjectsProjectTechnology> technologies;
  final String logoAssetUrl;
  final List<String> screenShotAssetUrls;
  final String? codeRepositoryUrl;
  final String? webPageUrl;

  ProjectsProject copyWith({
    String? name,
    String? description,
    String? longDescription,
    ProjectsProjectStatus? status,
    String? estimatedTimeExpended,
    List<ProjectsProjectTechnology>? technologies,
    String? logoAssetUrl,
    List<String>? screenShotAssetUrls,
    String? codeRepositoryUrl,
    String? webPageUrl,
  }) {
    return ProjectsProject(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      longDescription: longDescription ?? this.longDescription,
      status: status ?? this.status,
      estimatedTimeExpended:
          estimatedTimeExpended ?? this.estimatedTimeExpended,
      technologies: technologies ?? this.technologies,
      logoAssetUrl: logoAssetUrl ?? this.logoAssetUrl,
      screenShotAssetUrls: screenShotAssetUrls ?? this.screenShotAssetUrls,
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
        estimatedTimeExpended,
        logoAssetUrl,
        screenShotAssetUrls,
        codeRepositoryUrl,
        webPageUrl,
      ];
}
