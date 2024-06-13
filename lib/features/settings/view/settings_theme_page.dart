import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:flutter/material.dart';

class SettingsThemePage extends StatelessWidget {
  const SettingsThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkIcon =
        Icon(Icons.check, color: context.currentTheme.colorScheme.primary);

    return ListenableBuilder(
      listenable: locator<ThemeService>(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.settings_theme),
            centerTitle: false,
          ),
          bottomNavigationBar: const FooterF2DWidget(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(context.l10n.settings_theme_light),
                        leading: const Icon(Icons.light_mode),
                        trailing: locator<ThemeService>().realThemeMode ==
                                ThemeMode.light
                            ? checkIcon
                            : null,
                        onTap: () {
                          locator<ThemeService>()
                              .changeThemeMode(ThemeMode.light);
                        },
                      ),
                      ListTile(
                        title: Text(context.l10n.settings_theme_dark),
                        leading: const Icon(Icons.dark_mode),
                        trailing: locator<ThemeService>().realThemeMode ==
                                ThemeMode.dark
                            ? checkIcon
                            : null,
                        onTap: () {
                          locator<ThemeService>()
                              .changeThemeMode(ThemeMode.dark);
                        },
                      ),
                      ListTile(
                        title: Text(context.l10n.settings_theme_system),
                        leading: const Icon(Icons.settings),
                        trailing: locator<ThemeService>().realThemeMode ==
                                ThemeMode.system
                            ? checkIcon
                            : null,
                        onTap: () {
                          locator<ThemeService>()
                              .changeThemeMode(ThemeMode.system);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
