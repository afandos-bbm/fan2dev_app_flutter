import 'package:fan2dev/features/projects/domain/domain.dart';
import 'package:fan2dev/features/projects/domain/technology/projects_project_technology.dart';
import 'package:fan2dev/utils/result.dart';

List<ProjectsProjectTechnology> _technologies = [
  const ProjectsProjectTechnology(
    id: 1,
    name: 'Dart',
    type: ProjectsProjectTechnologyType.language,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/images/dart_logo.png',
  ),
  const ProjectsProjectTechnology(
    id: 2,
    name: 'Flutter',
    type: ProjectsProjectTechnologyType.framework,
    objective: ProjectsProjectTechnologyObjective.mobile,
    logoAssetUrl: 'assets/images/flutter_logo.png',
  ),
  const ProjectsProjectTechnology(
    id: 3,
    name: 'Firebase',
    type: ProjectsProjectTechnologyType.database,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/images/firebase_logo.png',
  ),
  const ProjectsProjectTechnology(
    id: 4,
    name: 'Git',
    type: ProjectsProjectTechnologyType.tool,
    objective: ProjectsProjectTechnologyObjective.frontend,
    logoAssetUrl: 'assets/images/git_logo.png',
  ),
  const ProjectsProjectTechnology(
    id: 5,
    name: 'Github',
    type: ProjectsProjectTechnologyType.tool,
    objective: ProjectsProjectTechnologyObjective.frontend,
    logoAssetUrl: 'assets/images/github_logo.png',
  ),
];

List<ProjectsProject> _projectList = [
  ProjectsProject(
    id: 1,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    longDescription:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    status: ProjectsProjectStatus.development,
    estimatedTimeExpended: '1mo',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[2],
      _technologies[3],
      _technologies[4],
    ],
    screenShotAssetUrls: const [
      'assets/images/fan2dev.png',
      'assets/images/fan2dev.png',
      'assets/images/fan2dev.png'
    ],
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
  ProjectsProject(
    id: 2,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    longDescription:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[2],
      _technologies[3],
      _technologies[4],
    ],
    status: ProjectsProjectStatus.soon,
    estimatedTimeExpended: '1mo',
    screenShotAssetUrls: const [
      'assets/images/fan2dev.png',
      'assets/images/fan2dev.png',
      'assets/images/fan2dev.png'
    ],
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
  ProjectsProject(
    id: 3,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    longDescription:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[2],
      _technologies[3],
      _technologies[4],
    ],
    status: ProjectsProjectStatus.finished,
    estimatedTimeExpended: '1mo',
    screenShotAssetUrls: const ['assets/images/fan2dev.png'],
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
  ProjectsProject(
    id: 4,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    longDescription:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together. Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[2],
      _technologies[3],
      _technologies[4],
    ],
    status: ProjectsProjectStatus.development,
    estimatedTimeExpended: '1mo',
    screenShotAssetUrls: const ['assets/images/fan2dev.png'],
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
];

abstract class LocalDataSource {
  Result<List<ProjectsProject>, Exception> getProjects();
  Result<ProjectsProject, Exception> getProjectById(int id);
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl();

  @override
  Result<List<ProjectsProject>, Exception> getProjects() {
    try {
      final projects = _projectList;

      return Result.success(data: projects);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Result<ProjectsProject, Exception> getProjectById(int id) {
    try {
      final project = _projectList.firstWhere(
        (element) => element.id == id,
        orElse: () {
          throw Exception('Project not found');
        },
      );
      return Result.success(data: project);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }
}
