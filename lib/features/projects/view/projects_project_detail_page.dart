import 'package:fan2dev/features/projects/projects.dart';
import 'package:fan2dev/l10n/l10n.dart';
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
            projectStatus: project.status,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.l10n.projects_time_expended} ${project.estimatedTimeExpended}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
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
