import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/provider_store/provider_store.dart';
import 'package:fan2dev/core/router/app_router.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/language/language.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:fan2dev/utils/widgets/toast_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';

/// MaterialApp widget that initializes the app.
/// It is the root of the app.
class MateApp extends StatelessWidget {
  const MateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastListOverlay<ToastModel>(
      itemBuilder: _buildToast,
      width: MediaQuery.of(context).size.width * 0.95,
      child: ChangeNotifierProvider<ThemeService>(
        create: (_) => ThemeService(),

        /// Initializes the app with the BlocProviderStore.
        child: BlocProviderStore.init(
          child: ListenableBuilder(
            listenable: locator<ThemeService>(),
            builder: (context, _) {
              return BlocBuilder<LanguageCubit, LanguageState>(
                builder: (context, state) {
                  final selectedLocale = Locale(state.selectedLanguage);
                  return MaterialApp.router(
                    title: 'fan2dev',
                    debugShowCheckedModeBanner: false,
                    scrollBehavior: _Fan2devCustomScrollBehavior(),
                    localizationsDelegates: const [
                      ...AppLocalizations.localizationsDelegates,
                      LocaleNamesLocalizationsDelegate(),
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                    theme: themes[CurrentTheme.light],
                    darkTheme: themes[CurrentTheme.dark],
                    themeMode: locator<ThemeService>().themeMode,
                    locale: selectedLocale,
                    routerConfig: router,
                    builder: (context, child) {
                      return ColorfulSafeArea(
                        color: locator<ThemeService>().isLightMode
                            ? context.currentTheme.colorScheme.primaryContainer
                            : Colors.black,
                        child: child!,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

ToastWidget _buildToast(
  BuildContext context,
  ToastModel item,
  int index,
  Animation<double> animation,
) {
  return ToastWidget(
    animation: animation,
    data: item,
    onTap: () {
      context.hideToast(
        item,
        (context, animation) => _buildToast(context, item, index, animation),
      );
    },
  );
}

class _Fan2devCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
