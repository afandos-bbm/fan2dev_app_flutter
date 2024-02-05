import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProjectsProjectDetailScreenshotsSectionWidget extends StatelessWidget {
  const ProjectsProjectDetailScreenshotsSectionWidget({
    required this.projectScreenShotAssetUrls,
    super.key,
  });

  final List<String> projectScreenShotAssetUrls;

  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      viewportFraction: 0.8,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.projects_details_screenshots,
          style: context.currentTheme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        Align(
          child: SmoothPageIndicator(
            controller: controller,
            count: projectScreenShotAssetUrls.length,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: kPrimaryColor,
              type: WormType.thin,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 600,
          decoration: BoxDecoration(
            color: kPrimaryColor[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: PageView.builder(
            controller: controller,
            itemCount: projectScreenShotAssetUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    projectScreenShotAssetUrls[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      kLogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
