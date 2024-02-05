import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/errors/error.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  const GenericErrorWidget({super.key, this.errorCode});

  static Widget builder(BuildContext context) => const GenericErrorWidget();

  final ErrorCodes? errorCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 50,
            color: context.themeColors.error,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            context.translate(
              errorCode ?? ErrorCodes.generic,
            ),
          ),
        ],
      ),
    );
  }
}
