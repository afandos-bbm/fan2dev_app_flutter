import 'package:fan2dev/features/about/widgets/about_image_carrousel_widget.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/material.dart';

class AboutHomePage extends StatelessWidget {
  const AboutHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AboutHomePageView();
  }
}

class AboutHomePageView extends StatelessWidget {
  const AboutHomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(kFan2devAboutProfilePath),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.l10n.about_title} 👋',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        context.l10n.about_sort_description,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          context.l10n.about_text_1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        kFan2devAboutFlutterDashPath,
                        width: 150,
                      ),
                    ],
                  ),
                  Text(
                    context.l10n.about_text_2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const AboutImageCarrouselWidget(),
                  Text(
                    context.l10n.about_text_3,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
