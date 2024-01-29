import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/material.dart';

class AboutHomePage extends StatelessWidget {
  const AboutHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AboutHeaderWidget(),
      ],
    );
  }
}

class AboutHeaderWidget extends StatelessWidget {
  const AboutHeaderWidget({super.key});

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
                    backgroundImage: AssetImage(kFan2devAboutPhotoPath),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${context.l10n.about_title} 👋',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        context.l10n.about_sort_description,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.bodySmall,
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
              child: Text.rich(
                textWidthBasis: TextWidthBasis.longestLine,
                softWrap: true,
                TextSpan(
                  text: context.l10n.about_text_1,
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: context.l10n.about_text_2,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: context.l10n.about_text_3,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
