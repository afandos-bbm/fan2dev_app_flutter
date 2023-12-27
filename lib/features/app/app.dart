import 'package:flutter/material.dart';
import 'package:fan2dev/core/provider_store/provider_store.dart';
import 'package:fan2dev/core/router/app_router.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/language/language.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';

/// MaterialApp widget that initializes the app.
/// It is the root of the app.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeService>(
      create: (_) => ThemeService(),

      /// Initializes the app with the BlocProviderStore.
      child: BlocProviderStore.init(
        child: Consumer<ThemeService>(
          builder: (_, themeService, __) {
            return BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                final selectedLocale = Locale(state.selectedLanguage);
                return MaterialApp.router(
                  title: 'fan2dev',
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    ...AppLocalizations.localizationsDelegates,
                    LocaleNamesLocalizationsDelegate(),
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  theme: themeService.themeData,
                  darkTheme: themeService.themeData,
                  themeMode: themeService.themeMode,
                  locale: selectedLocale,
                  routerConfig: router,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
