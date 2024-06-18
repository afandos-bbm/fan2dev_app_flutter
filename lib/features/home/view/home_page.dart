import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/home/cubit/home_page_cubit/home_page_cubit.dart';
import 'package:fan2dev/features/home/view/widgets/f2d_app_bar_widget.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: _HomePageView(child: child),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: locator<ThemeService>().isLightMode
          ? context.currentTheme.colorScheme.primaryContainer
          : Colors.black,
      child: ListenableBuilder(
        listenable: locator<ThemeService>(),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: locator<ThemeService>().themeMode == ThemeMode.dark
                ? Colors.black
                : context.themeColors.primary,
            bottomNavigationBar: kIsWeb ? const FooterF2DWidget() : null,
            body: Column(
              children: [
                if (!kIsWeb)
                  const FooterF2DWidget()
                else ...[
                  const SizedBox(height: 5),
                  const F2DAppBarWidget(),
                  const SizedBox(height: 5),
                ],
                Flexible(
                  child: Card(
                    surfaceTintColor:
                        locator<ThemeService>().themeMode == ThemeMode.dark
                            ? Colors.grey[900]
                            : Colors.grey[200],
                    margin: EdgeInsets.zero,
                    shape: kIsWeb
                        ? const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          )
                        : const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                    child: ClipRRect(
                      borderRadius: kIsWeb
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                      child: BlocBuilder<HomePageCubit, HomePageState>(
                        builder: (context, state) {
                          return child;
                        },
                      ),
                    ),
                  ),
                ),
                if (!kIsWeb) ...[
                  const SizedBox(height: 5),
                  const F2DAppBarWidget(),
                  const SizedBox(height: 5),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
