import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';

class ObPostsPage extends StatelessWidget {
  const ObPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeColors.secondary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/onboarding/3');
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Gif(
                  width: 300,
                  height: 300,
                  autostart: Autostart.once,
                  image: AssetImage(
                    locator<ThemeService>().isDarkMode
                        ? 'assets/animations/ob_posts_black.gif'
                        : 'assets/animations/ob_posts_white.gif',
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 120,
                      height: 120,
                      color: context.themeColors.background,
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: 100,
                        height: 100,
                      ).animate(
                        autoPlay: true,
                        effects: [
                          const ScaleEffect(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOut,
                          ),
                          const FadeEffect(
                            duration: Duration(milliseconds: 2000),
                            curve: Curves.easeInOut,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                context.l10n.ob_posts_title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                context.l10n.ob_posts_subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
