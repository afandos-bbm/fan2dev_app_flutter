import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'projects_project_technology.g.dart';

enum ProjectsProjectTechnologyType { language, framework, database, tool }

enum ProjectsProjectTechnologyObjective { backend, frontend, mobile, desktop }

@JsonSerializable()
class ProjectsProjectTechnology extends Equatable {
  const ProjectsProjectTechnology({
    required this.id,
    required this.name,
    required this.type,
    required this.objective,
    required this.logoAssetUrl,
    required this.url,
  });

  factory ProjectsProjectTechnology.fromJson(Map<String, dynamic> json) =>
      _$ProjectsProjectTechnologyFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsProjectTechnologyToJson(this);

  final int id;
  final String name;
  final ProjectsProjectTechnologyType type;
  final ProjectsProjectTechnologyObjective objective;
  final String logoAssetUrl;
  final String url;

  ProjectsProjectTechnology copyWith({
    String? name,
    ProjectsProjectTechnologyType? type,
    ProjectsProjectTechnologyObjective? objective,
    String? logoAssetUrl,
    String? url,
  }) {
    return ProjectsProjectTechnology(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      objective: objective ?? this.objective,
      logoAssetUrl: logoAssetUrl ?? this.logoAssetUrl,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        objective,
        logoAssetUrl,
        url,
      ];
}
