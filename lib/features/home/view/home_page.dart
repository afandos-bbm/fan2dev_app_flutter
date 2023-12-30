import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/home/cubit/home_page_cubit.dart';
import 'package:fan2dev/features/home/view/widgets/f2d_app_bar_widget.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.child});

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
    return ListenableBuilder(
        listenable: locator<ThemeService>(),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: locator<ThemeService>().themeMode == ThemeMode.dark
                ? Colors.black
                : context.read<ThemeService>().themeData!.colorScheme.primary,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 70),
                const F2DAppBarWidget(),
                const SizedBox(height: 5),
                Flexible(
                  child: Card(
                    color: locator<ThemeService>().themeMode == ThemeMode.dark
                        ? Colors.grey[900]
                        : Colors.grey[200],
                    margin: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: BlocBuilder<HomePageCubit, HomePageState>(
                        builder: (context, state) {
                          return child;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
