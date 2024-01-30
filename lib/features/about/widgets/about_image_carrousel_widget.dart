import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutImageCarrouselWidget extends StatelessWidget {
  const AboutImageCarrouselWidget({
    required this.carouselImages,
    super.key,
  });

  final List<String> carouselImages;

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
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: carouselImages[index],
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Image.asset(
                        kLogoPath,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: controller,
          count: carouselImages.length,
          effect: const JumpingDotEffect(
            activeDotColor: kPrimaryColor,
            verticalOffset: 10,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
