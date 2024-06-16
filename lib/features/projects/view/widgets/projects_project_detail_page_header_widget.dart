import 'package:auto_size_text/auto_size_text.dart';
import 'package:fan2dev/features/projects/projects.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectsProjectDetailPageHeaderWidget extends StatelessWidget {
  const ProjectsProjectDetailPageHeaderWidget({
    required this.projectName,
    required this.projectLogoAssetUrl,
    required this.projectStatus,
    super.key,
  });

  final String projectName;
  final String projectLogoAssetUrl;
  final ProjectsProjectStatus projectStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/projects'),
              ),
              const SizedBox(width: 15),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  projectLogoAssetUrl,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    kLogoPath,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              AutoSizeText(
                projectName,
                style: context.currentTheme.textTheme.titleLarge,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ProjectsProjectItemCardChipWidget(
              type: projectStatus,
            ),
          ),
        ],
      ),
    );
  }
}
