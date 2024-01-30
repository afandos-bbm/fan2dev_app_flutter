import 'package:fan2dev/features/projects/domain/domain.dart';
import 'package:fan2dev/utils/result.dart';

List<ProjectsProject> _projectList = [
  const ProjectsProject(
    id: 1,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    status: ProjectsProjectStatus.development,
    estimatedDuration: '1mo',
    screenShotAssetUrl: 'assets/images/fan2dev.png',
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
  const ProjectsProject(
    id: 2,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    status: ProjectsProjectStatus.soon,
    estimatedDuration: '1mo',
    screenShotAssetUrl: 'assets/images/fan2dev.png',
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
  const ProjectsProject(
    id: 3,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    status: ProjectsProjectStatus.finished,
    estimatedDuration: '1mo',
    screenShotAssetUrl: 'assets/images/fan2dev.png',
    codeRepositoryUrl: 'https://github.com',
    webPageUrl: 'https://fan2dev.com',
  ),
  const ProjectsProject(
    id: 4,
    name: 'Fan2Dev',
    logoAssetUrl: 'assets/images/fan2dev_logo.png',
    description:
        'Fan2Dev is a community of developers and designers who are passionate about building and learning together.',
    status: ProjectsProjectStatus.development,
    estimatedDuration: '1mo',
    screenShotAssetUrl: 'assets/images/fan2dev.png',
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
