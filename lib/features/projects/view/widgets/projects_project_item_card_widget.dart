import 'package:fan2dev/features/projects/projects.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectsProjectItemCardWidget extends StatelessWidget {
  const ProjectsProjectItemCardWidget({
    required this.project,
    super.key,
  });

  final ProjectsProject project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/projects/${project.id}',
          extra: project,
        );
      },
      child: SizedBox(
        height: 250,
        child: Card(
          elevation: 1,
          color: kPrimaryColor,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Flexible(
                child: Card(
                  elevation: 1,
                  color: kPrimaryColor[50],
                  margin: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ColoredBox(
                                color: Colors.white,
                                child: Image.asset(
                                  project.screenShotAssetUrls.first,
                                  width: 100,
                                  height: 200,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      kLogoPath,
                                      width: 100,
                                      height: 200,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 5,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              project.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                          Text(
                                            '~${project.estimatedTimeExpended}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        project.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Divider(
                                        color: kPrimaryColor,
                                        height: 1,
                                        thickness: 0.4,
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProjectsProjectItemCardChipWidget(
                                              type: project.status,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                if (project.codeRepositoryUrl !=
                                                    null)
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    icon:
                                                        const Icon(Icons.code),
                                                    tooltip: context.l10n
                                                        .projects_open_repository,
                                                    onPressed: () {
                                                      tryToOpenUrl(
                                                        project
                                                            .codeRepositoryUrl!,
                                                      );
                                                    },
                                                  ),
                                                if (project.websiteUrl != null)
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    icon: const Icon(
                                                      Icons.public,
                                                    ),
                                                    tooltip: context.l10n
                                                        .projects_open_website,
                                                    onPressed: () {
                                                      tryToOpenUrl(
                                                        project.websiteUrl!,
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 10,
                        left: 80,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: kPrimaryColor[50]!,
                                  width: 3,
                                ),
                              ),
                              child: Image.asset(
                                project.logoAssetUrl,
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    kLogoPath,
                                    width: 40,
                                    height: 40,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
