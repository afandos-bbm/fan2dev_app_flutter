import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/features/projects/domain/project/projects_project.dart';
import 'package:fan2dev/l10n/l10n.dart';
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

    if (locator<ThemeService>().isDarkMode) {
      switch (type) {
        case ProjectsProjectStatus.soon:
          chipColor = Colors.orange[900]!;
          chipBorderColor = Colors.orange[700]!;
        case ProjectsProjectStatus.development:
          chipColor = Colors.green[900]!;
          chipBorderColor = Colors.green[700]!;
        case ProjectsProjectStatus.finished:
          chipColor = Colors.blue[900]!;
          chipBorderColor = Colors.blue[700]!;
      }
    } else {
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
    }

    return Chip(
      backgroundColor: chipColor,
      label: Text(
        context.l10n.projects_status(type.name),
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
