import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/open_url.dart';
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
              return const ProjectItemCardWidget(
                projectName: 'Project name',
                projectDescription: 'Project description',
                projectChipText: 'Project',
                projectImageAssetUrl: 'assets/images/flutter_logo.png',
                projectCodeRepositoryUrl: 'https://github.com',
                projectWebPageUrl: 'https://flutter.dev',
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectItemCardWidget extends StatelessWidget {
  const ProjectItemCardWidget({
    required this.projectName,
    required this.projectDescription,
    required this.projectChipText,
    required this.projectImageAssetUrl,
    this.projectCodeRepositoryUrl,
    this.projectWebPageUrl,
    super.key,
  });

  final String projectName;
  final String projectDescription;
  final String projectChipText;
  final String projectImageAssetUrl;
  final String? projectCodeRepositoryUrl;
  final String? projectWebPageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan[50],
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: Colors.white,
                child: Image.asset(
                  projectImageAssetUrl,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      kLogoPath,
                      width: 100,
                      height: 100,
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    projectName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    projectDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          projectChipText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (projectCodeRepositoryUrl != null)
                            IconButton(
                              icon: const Icon(Icons.code),
                              tooltip: 'Open code repository',
                              onPressed: () {
                                tryToOpenUrl(projectCodeRepositoryUrl!);
                              },
                            ),
                          if (projectWebPageUrl != null)
                            IconButton(
                              icon: const Icon(Icons.public),
                              tooltip: 'Open web page',
                              onPressed: () {
                                tryToOpenUrl(projectWebPageUrl!);
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
