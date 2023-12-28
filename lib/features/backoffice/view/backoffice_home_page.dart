import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackofficeHomePage extends StatelessWidget {
  const BackofficeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Backoffice Home Page'),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Go to Home'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.go('/');
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
