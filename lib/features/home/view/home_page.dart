import 'package:fan2dev/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fan2dev/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomePageView();
  }
}

class _HomePageView extends StatelessWidget {
  _HomePageView();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appName),
      ),
      body: Form(
          child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              final String email = _emailController.text;
              final String password = _passwordController.text;

              FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then((value) {
                l(value.toString(), name: '🆕 onCreate - FirebaseAuth');
              }).catchError((error) {
                l(error.toString(), name: '❌ onError - FirebaseAuth');
              });
            },
            child: const Text(
              "Login",
            ),
          ),
        ],
      )),
    );
  }
}
