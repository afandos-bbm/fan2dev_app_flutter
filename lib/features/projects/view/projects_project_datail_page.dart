import 'package:fan2dev/features/projects/domain/project/projects_project.dart';
import 'package:fan2dev/features/projects/view/widgets/projects_project_item_card_widget.dart';
import 'package:flutter/material.dart';

class ProjectsProjectDetailPage extends StatelessWidget {
  const ProjectsProjectDetailPage({
    required this.project,
    super.key,
  });

  final ProjectsProject project;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProjectsProjectDetailPageHeaderWidget(
          projectName: project.name,
          projectLogoAssetUrl: project.logoAssetUrl,
        ),
        ProjectsProjectItemCardWidget(project: project),
      ],
    );
  }
}

class ProjectsProjectDetailPageHeaderWidget extends StatelessWidget {
  const ProjectsProjectDetailPageHeaderWidget({
    required this.projectName,
    required this.projectLogoAssetUrl,
    super.key,
  });

  final String projectName;
  final String projectLogoAssetUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(projectLogoAssetUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              projectName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
