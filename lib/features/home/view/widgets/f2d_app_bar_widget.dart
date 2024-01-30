import 'package:fan2dev/features/home/home.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class F2DAppBarWidget extends StatelessWidget {
  const F2DAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: InkWell(
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BlocBuilder<HomePageCubit, HomePageState>(
              builder: (context, state) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.zero,
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  Size.zero,
                                ),
                                alignment: Alignment.bottomCenter,
                                enableFeedback: true,
                              ),
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
                                      : Colors.white70,
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
                                      : Colors.white70,
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
                                      : Colors.white70,
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
                                      : Colors.white70,
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
                  ],
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              context.push('/settings');
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
