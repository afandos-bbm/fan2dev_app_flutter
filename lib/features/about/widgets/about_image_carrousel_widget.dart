import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutImageCarrouselWidget extends StatelessWidget {
  const AboutImageCarrouselWidget({super.key});

  List<String> get images => [
        kFan2devAboutAkiraPath,
        kFan2devAboutArenalPath,
        kFan2devAboutSwimmingPath,
        kFan2devAboutCarPath,
      ];

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8);
    return Column(
      children: [
        const SizedBox(height: 1),
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
            controller: controller,
            count: images.length,
            effect: const JumpingDotEffect(
              activeDotColor: kPrimaryColor,
              verticalOffset: 10,
            )),
        const SizedBox(height: 10),
      ],
    );
  }
}
