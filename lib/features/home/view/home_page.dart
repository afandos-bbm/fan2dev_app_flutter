import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/home/cubit/home_page_cubit.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 70),
          SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      context.push('/log-in');
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset(
                          kLogoPath,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  child: Text(
                                    context.l10n.menu_blog,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context
                                                  .watch<HomePageCubit>()
                                                  .state
                                                  .index ==
                                              0
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HomePageCubit>()
                                        .changeBottomNavBar(0);
                                    context.go('/blog');
                                  },
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  child: Text(
                                    context.l10n.menu_projects,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context
                                                  .watch<HomePageCubit>()
                                                  .state
                                                  .index ==
                                              1
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HomePageCubit>()
                                        .changeBottomNavBar(1);
                                    context.go('/projects');
                                  },
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  child: Text(
                                    context.l10n.menu_about,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context
                                                  .watch<HomePageCubit>()
                                                  .state
                                                  .index ==
                                              2
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HomePageCubit>()
                                        .changeBottomNavBar(2);
                                    context.go('/about');
                                  },
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  child: Text(
                                    context.l10n.menu_contact,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context
                                                  .watch<HomePageCubit>()
                                                  .state
                                                  .index ==
                                              3
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HomePageCubit>()
                                        .changeBottomNavBar(3);
                                    context.go('/contact');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            context.push('/settings');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              )),
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
  }
}
