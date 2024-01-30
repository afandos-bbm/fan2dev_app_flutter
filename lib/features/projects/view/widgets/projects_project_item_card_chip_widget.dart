import 'package:fan2dev/features/projects/domain/project/projects_project.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';

class ProjectsProjectItemCardChipWidget extends StatelessWidget {
  const ProjectsProjectItemCardChipWidget({
    required this.type,
    super.key,
  });

  final ProjectsProjectStatus type;

  @override
  Widget build(BuildContext context) {
    // change chip color and border color based on type
    Color chipColor;
    Color chipBorderColor;

    switch (type) {
      case ProjectsProjectStatus.soon:
        chipColor = Colors.orange[50]!;
        chipBorderColor = Colors.orange[200]!;
      case ProjectsProjectStatus.development:
        chipColor = Colors.green[50]!;
        chipBorderColor = Colors.green[200]!;
      case ProjectsProjectStatus.finished:
        chipColor = Colors.blue[50]!;
        chipBorderColor = Colors.blue[200]!;
    }

    return Chip(
      backgroundColor: chipColor,
      label: Text(
        type.name.toUpperCase(),
        style: context.currentTheme.textTheme.labelSmall,
      ),
      shape: context.currentTheme.chipTheme.shape!.copyWith(
        side: BorderSide(
          color: chipBorderColor,
        ),
      ),
    );
  }
}
