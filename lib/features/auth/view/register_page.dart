import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fan2dev/core/auth_service/auth_service.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

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
                context.pop();
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

                      // password strength min 8, 1 uppercase, 1 lowercase, 1 number
                      if (value.length < 6) {
                        return context.l10n.contact_error_password_length;
                      }

                      if (!value.contains(RegExp('[A-Z]'))) {
                        return context.l10n.contact_error_password_weak;
                      }

                      if (!value.contains(RegExp('[a-z]'))) {
                        return context.l10n.contact_error_password_weak;
                      }

                      if (!value.contains(RegExp('[0-9]'))) {
                        return context.l10n.contact_error_password_weak;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        try {
                          final userCredential = await locator<FirebaseClient>()
                              .firebaseAuthInstance
                              .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                          await locator<FirebaseClient>()
                              .firebaseAuthInstance
                              .currentUser!
                              .updateDisplayName(email.split('@').first);

                          final db = FirebaseFirestore.instance;

                          await db
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set({
                            'createdAt': FieldValue.serverTimestamp(),
                            'isAdmin': false,
                            'displayName': email.split('@').first,
                          });

                          final data = await db
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .get();

                          locator<AuthService>().login(
                            data.data()!.containsKey('isAdmin') &&
                                data.data()!['isAdmin'] == true,
                            DateTime.fromMillisecondsSinceEpoch(
                              (data.data()!['createdAt'] as Timestamp)
                                  .millisecondsSinceEpoch,
                            ),
                          );
                        } catch (e) {
                          l(e.toString(), name: '❌ onError - FirebaseAuth');
                        }
                      },
                      child: Text(
                        context.l10n.login_register,
                      ),
                    ),
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
