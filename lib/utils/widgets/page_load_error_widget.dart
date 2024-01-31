import 'package:flutter/material.dart';

class PageLoadErrorWidget extends StatelessWidget {
  const PageLoadErrorWidget({
    required this.onRefresh,
    required this.errorMessage,
    super.key,
  });

  final VoidCallback onRefresh;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            'Something went wrong. \nPlease try again. \n$errorMessage',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }
}
