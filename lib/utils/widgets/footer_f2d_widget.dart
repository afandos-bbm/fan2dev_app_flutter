import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FooterF2DWidget extends StatelessWidget {
  const FooterF2DWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: locator<ThemeService>().themeMode == ThemeMode.dark
            ? Colors.black
            : context.read<ThemeService>().themeData!.colorScheme.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogoPath,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(
                width: 1,
              ),
              Text(
                context.l10n.footer_text,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
