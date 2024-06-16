import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/core/notification_service/notification_service.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ObNotificationsPage extends StatelessWidget {
  const ObNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeColors.secondary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!kIsWeb) locator<NotificationService>().disableNotifications();

          locator<SharedPreferencesService>().hasDoneOnboarding = true;
          context.go('/');
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
                        ? 'assets/animations/ob_notifications_black.gif'
                        : 'assets/animations/ob_notifications_white.gif',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
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
                context.l10n.ob_notifications_title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                context.l10n.ob_notifications_subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            if (!kIsWeb)
              ElevatedButton.icon(
                onPressed: () {
                  locator<NotificationService>().enableNotifications();

                  locator<SharedPreferencesService>().hasDoneOnboarding = true;
                  context.go('/');
                },
                icon: Icon(
                  Icons.notifications_active_rounded,
                  color: context.themeColors.background,
                ),
                label: Text(
                  context.l10n.ob_notifications_button,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: context.themeColors.background,
                      ),
                ),
              )
            else ...[
              const SizedBox(height: 20),
              Text(
                context.l10n.ob_notifications_download_app,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      launchUrlString(
                          'https://play.google.com/store/apps/details?id=',);
                    },
                    icon: const Icon(Icons.apple_rounded),
                    label: Text(
                      context.l10n.ob_notifications_download_app_ios,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: context.themeColors.background,
                          ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      launchUrlString(
                          'https://play.google.com/store/apps/details?id=',);
                    },
                    icon: const Icon(Icons.android_rounded),
                    label: Text(
                      context.l10n.ob_notifications_download_app_android,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: context.themeColors.background,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
