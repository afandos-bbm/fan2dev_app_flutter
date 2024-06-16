import 'package:fan2dev/features/language/cubit/language_cubit.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SettingsNotificationsPage extends StatelessWidget {
  const SettingsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkIcon =
        Icon(Icons.check, color: context.currentTheme.colorScheme.primary);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_language),
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
                    title: Text(context.l10n.settings_language_es),
                    leading: SvgPicture.asset(
                      kSpanishFlagPath,
                      width: 30,
                    ),
                    trailing: context.watch<LanguageCubit>().locale == 'es'
                        ? checkIcon
                        : null,
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage('es');
                    },
                  ),
                  ListTile(
                    title: Text(context.l10n.settings_language_va),
                    leading: SvgPicture.asset(
                      kValencianFlagPath,
                      width: 30,
                    ),
                    trailing: context.watch<LanguageCubit>().locale == 'ca'
                        ? checkIcon
                        : null,
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage('ca');
                    },
                  ),
                  ListTile(
                    title: Text(context.l10n.settings_language_en),
                    leading: Container(
                      width: 31,
                      height: 23,
                      color: Colors.white,
                      child: SvgPicture.asset(
                        kEnglishFlagPath,
                        width: 30,
                      ),
                    ),
                    trailing: context.watch<LanguageCubit>().locale == 'en'
                        ? checkIcon
                        : null,
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage('en');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
