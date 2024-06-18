import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fan2dev/core/auth_service/auth_service.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:fan2dev/utils/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginPageView();
  }
}

class _LoginPageView extends StatelessWidget {
  _LoginPageView();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return ColorfulSafeArea(
      color: locator<ThemeService>().isLightMode
          ? context.currentTheme.colorScheme.primaryContainer
          : Colors.black,
      top: false,
      child: ColorfulSafeArea(
        color: locator<ThemeService>().isLightMode
            ? context.currentTheme.colorScheme.background
            : Colors.black,
        bottom: false,
        child: Scaffold(
          backgroundColor: context.currentTheme.colorScheme.background,
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: FloatingActionButton(
              onPressed: () {
                context.go('/');
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          bottomNavigationBar: const FooterF2DWidget(),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogoPath,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: inputDecoration.copyWith(
                      labelText: context.l10n.login_email,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.contact_error_empty_message;
                      }

                      if (!value.contains('@') || !value.contains('.')) {
                        return context.l10n.contact_error_invalid_email;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: inputDecoration.copyWith(
                      labelText: context.l10n.login_password,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.contact_error_empty_message;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text(
                          context.l10n.login_register,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          final userCredentials =
                              await locator<FirebaseClient>()
                                  .firebaseAuthInstance
                                  .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );

                          if (userCredentials.user == null) {
                            context.showToast(
                              ToastModel(
                                message: context.l10n.login_error,
                                type: ToastType.error,
                              ),
                            );
                            return;
                          }

                          final db = FirebaseFirestore.instance;

                          final user = await db
                              .collection('users')
                              .doc(userCredentials.user!.uid)
                              .get();

                          if (!user.exists) {
                            context.showToast(
                              ToastModel(
                                message: context.l10n.login_error,
                                type: ToastType.error,
                              ),
                            );
                            return;
                          }

                          locator<AuthService>().login(
                            user.data()!.containsKey('isAdmin') &&
                                user.data()!['isAdmin'] == true,
                            DateTime.fromMillisecondsSinceEpoch(
                              (user.data()!['createdAt'] as Timestamp)
                                  .millisecondsSinceEpoch,
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
