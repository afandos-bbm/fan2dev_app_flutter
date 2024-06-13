import 'package:fan2dev/features/projects/domain/technology/projects_project_technology.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          context.l10n.projects_details_technologies,
          style: context.currentTheme.textTheme.headlineMedium,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: technologies.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 15),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: SvgPicture.asset(
                                  technologies[index].logoAssetUrl,
                                  width: 30,
                                  height: 30,
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
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              technologies[index].type.name.capitalize(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 5),
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
                              technologies[index].objective.name.capitalize(),
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
