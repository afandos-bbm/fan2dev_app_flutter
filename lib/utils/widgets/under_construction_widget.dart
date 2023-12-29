import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
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
          FooterF2DWidget(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
