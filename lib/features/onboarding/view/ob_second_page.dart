import 'package:fan2dev/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ObSecondPage extends StatelessWidget {
  const ObSecondPage({super.key});

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
            const SizedBox(height: 20),
            Text(
              'Connect with other developers',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Share your knowledge and learn from others',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                locator<SharedPreferencesService>().hasDoneOnboarding = true;
                context.go('/');
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
