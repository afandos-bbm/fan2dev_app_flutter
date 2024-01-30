import 'package:fan2dev/features/projects/domain/project/projects_project.dart';
import 'package:fan2dev/features/projects/view/widgets/projects_project_item_card_widget.dart';
import 'package:flutter/material.dart';

class ProjectsHomePage extends StatelessWidget {
  const ProjectsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectsHomePageView();
  }
}

class ProjectsHomePageView extends StatelessWidget {
  const ProjectsHomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Welcome to my projects.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'Here you can find some of my projects. I hope you like them. If you have any questions, please contact me.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            itemBuilder: (context, index) {
              return const ProjectsProjectItemCardWidget(
                project: ProjectsProject(
                  id: 1,
                  name: 'Fan2Dev',
                  status: ProjectsProjectStatus.finished,
                  estimatedDuration: '1mo',
                  description:
                      'Fan2Dev is a Flutter app that allows you to follow the latest news about Flutter and Dart.',
                  screenShotAssetUrl: 'assets/images/fan2dev.png',
                  logoAssetUrl: 'assets/images/fan2dev.png',
                  codeRepositoryUrl: 'https://github.com',
                  webPageUrl: 'https://fan2dev.com',
                ),
              );
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
