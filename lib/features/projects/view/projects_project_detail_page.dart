import 'package:fan2dev/features/projects/domain/project/projects_project.dart';
import 'package:fan2dev/features/projects/view/widgets/projects_project_detail_page_header_widget.dart';
import 'package:fan2dev/features/projects/view/widgets/projects_project_detail_screenshots_section_widget.dart';
import 'package:fan2dev/features/projects/view/widgets/projects_project_detail_technologies_section_widget.dart';
import 'package:flutter/material.dart';

class ProjectsProjectDetailPage extends StatelessWidget {
  const ProjectsProjectDetailPage({
    required this.project,
    super.key,
  });

  final ProjectsProject project;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          ProjectsProjectDetailPageHeaderWidget(
            projectName: project.name,
            projectLogoAssetUrl: project.logoAssetUrl,
            projectEstimatedTimeExpended: project.estimatedTimeExpended,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.longDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ProjectsProjectDetailTechnologiesSectionWidget(
                  technologies: project.technologies,
                ),
                const SizedBox(height: 20),
                if (project.screenShotAssetUrls.isNotEmpty)
                  ProjectsProjectDetailScreenshotsSectionWidget(
                    projectScreenShotAssetUrls: project.screenShotAssetUrls,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
