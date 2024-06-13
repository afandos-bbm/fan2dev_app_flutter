import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/language/cubit/language_cubit.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SettingsHomePage extends StatelessWidget {
  const SettingsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: locator<ThemeService>(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.settings_title),
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
                        title: Text(context.l10n.settings_language),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.translatedLanguage(
                                context.watch<LanguageCubit>().locale,
                              ),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            if (context.watch<LanguageCubit>().locale == 'en')
                              Container(
                                width: 15,
                                height: 12,
                                color: Colors.white,
                                child: SvgPicture.asset(
                                  kEnglishFlagPath,
                                  width: 15,
                                ),
                              )
                            else if (context.watch<LanguageCubit>().locale ==
                                'es')
                              SvgPicture.asset(
                                kSpanishFlagPath,
                                width: 15,
                              )
                            else
                              SvgPicture.asset(
                                kValencianFlagPath,
                                width: 15,
                              ),
                            const SizedBox(width: 5),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        leading: const Icon(Icons.language),
                        onTap: () {
                          context.push('/settings/language');
                        },
                      ),
                      ListTile(
                        title: Text(context.l10n.settings_theme),
                        leading: const Icon(Icons.nightlight_round),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.translatedThemeMode(
                                locator<ThemeService>().realThemeMode,
                              ),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        onTap: () {
                          context.push('/settings/theme');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextButton(
                    onPressed: () {
                      context.push('/privacy-policy');
                    },
                    child: Text(
                      context.l10n.settings_privacy_policy,
                      style: TextStyle(
                        color: context.themeColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
