import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ObFirstPage extends StatelessWidget {
  const ObFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/app_logo.png',
              width: 300,
              height: 300,
            ),
            Text(
              'Welcome to Fan2Dev',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'The best place to learn and share your knowledge',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/onboarding/2');
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
