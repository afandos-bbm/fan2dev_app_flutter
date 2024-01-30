import 'package:fan2dev/features/projects/domain/technology/projects_project_technology.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';

class ProjectsProjectDetailTechnologiesSectionWidget extends StatelessWidget {
  const ProjectsProjectDetailTechnologiesSectionWidget({
    required this.technologies,
    super.key,
  });

  final List<ProjectsProjectTechnology> technologies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Technologies',
          style: context.currentTheme.textTheme.headlineMedium,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: technologies.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.55,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                technologies[index].logoAssetUrl,
                                width: 20,
                                height: 20,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  kLogoPath,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              technologies[index].name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Chip(
                            padding: EdgeInsets.zero,
                            elevation: 2,
                            side: BorderSide(
                              color: kPrimaryColor[200]!,
                            ),
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            label: Text(
                              technologies[index].type.name,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Chip(
                            padding: EdgeInsets.zero,
                            elevation: 2,
                            side: BorderSide(
                              color: kPrimaryColor[200]!,
                            ),
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            label: Text(
                              technologies[index].objective.name,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
