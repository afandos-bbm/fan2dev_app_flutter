import 'package:flutter/material.dart';

class UnderConstructionWidget extends StatelessWidget {
  const UnderConstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Icon(
            Icons.construction,
            size: 100,
          ),
          Text('Under Construction'),
          Spacer(),
        ],
      ),
    );
  }
}
