import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectsProjectDetailPageHeaderWidget extends StatelessWidget {
  const ProjectsProjectDetailPageHeaderWidget({
    required this.projectName,
    required this.projectLogoAssetUrl,
    required this.projectEstimatedTimeExpended,
    super.key,
  });

  final String projectName;
  final String projectLogoAssetUrl;
  final String projectEstimatedTimeExpended;

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
              Text(
                projectName,
                style: context.currentTheme.textTheme.titleLarge,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              projectEstimatedTimeExpended,
              style: context.currentTheme.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
