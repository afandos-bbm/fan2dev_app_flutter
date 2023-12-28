import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/material.dart';

class FooterF2DWidget extends StatelessWidget {
  const FooterF2DWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          kLogoPath,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          context.l10n.footer_text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
