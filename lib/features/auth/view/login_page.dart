import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fan2dev/l10n/l10n.dart';
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

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final String email = _emailController.text;
                      final String password = _passwordController.text;

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) {
                        context.go('/backoffice');
                      }).catchError((error) {
                        l(error.toString(), name: '❌ onError - FirebaseAuth');
                      });
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),
                ),
                const Spacer(),
                const FooterF2DWidget(),
                const SizedBox(
                  height: 0,
                ),
              ],
            )),
      ),
    );
  }
}
