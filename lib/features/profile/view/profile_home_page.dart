import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fan2dev/core/auth_service/auth_service.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: locator<ThemeService>().isLightMode
          ? context.currentTheme.colorScheme.primaryContainer
          : Colors.black,
      child: ListenableBuilder(
        listenable: locator<AuthService>(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.profile_title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () {
                  context.go('/');
                },
              ),
            ),
            bottomNavigationBar: const FooterF2DWidget(),
            floatingActionButton: locator<AuthService>().isAdmin ?? false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          context.go('/backoffice');
                        },
                        heroTag: null,
                        child: const Icon(Icons.dashboard),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          locator<AuthService>().logout();
                          locator<FirebaseClient>()
                              .firebaseAuthInstance
                              .signOut();
                          context.go('/');
                        },
                        heroTag: null,
                        child: const Icon(Icons.logout),
                      ),
                    ],
                  )
                : FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      locator<AuthService>().logout();
                      locator<FirebaseClient>().firebaseAuthInstance.signOut();
                      context.go('/');
                    },
                    child: const Icon(Icons.logout),
                  ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      locator<FirebaseClient>()
                              .firebaseAuthInstance
                              .currentUser!
                              .photoURL ??
                          '',
                    ),
                    child: locator<FirebaseClient>()
                                .firebaseAuthInstance
                                .currentUser!
                                .photoURL ==
                            null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    locator<FirebaseClient>()
                            .firebaseAuthInstance
                            .currentUser!
                            .displayName ??
                        '',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    locator<FirebaseClient>()
                        .firebaseAuthInstance
                        .currentUser!
                        .email!,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
