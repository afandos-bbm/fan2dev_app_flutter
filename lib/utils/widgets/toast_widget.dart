import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

/// Displays a toast message.
/// See [ToastModel] for the data to pass to this widget.
/// See [ToastType] for available types.
/// See [ToastWidget] to see the icon and color associated with each type.
class ToastModel {
  /// Creates a toast message.
  ///
  /// * [message] is the message to display.
  /// Must be less than 70 characters.
  ///
  /// See [ToastModel] for the data to pass to this widget.
  /// See [ToastType] for available types.
  /// See [ToastWidget] to see the icon and color associated with each type.
  ToastModel({
    required this.message,
    required this.type,
  }) : assert(
          message.length <= 70 && message.isNotEmpty,
          'Message is too long or empty',
        );

  /// The message to display.
  /// Must be less than 70 characters.
  /// Cannot be empty.
  final String message;

  /// The type of toast to display.
  /// See [ToastType] for available types.
  /// Defaults to [ToastType.info].
  /// See [ToastWidget] to see the icon and color associated with each type.
  final ToastType type;
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    required this.animation,
    required this.data,
    this.onTap,
    super.key,
  });

  final Animation<double> animation;
  final VoidCallback? onTap;
  final ToastModel data;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: context.themeColors.onSecondaryContainer);

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 5),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: context.themeColors.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border(
                bottom: BorderSide(
                  color: _getTypeColor(data.type),
                  width: 4,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(
                        _getTypeIcon(data.type),
                        size: 20,
                        color: _getTypeColor(data.type),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          data.message,
                          style: textStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: context.themeColors.onSecondaryContainer,
                        ),
                        onPressed: () => onTap?.call(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const Map<ToastType, Color> _typeColors = {
    ToastType.success: kSuccessSwatch,
    ToastType.warning: kWarningSwatch,
    ToastType.info: kInfoSwatch,
    ToastType.error: kDangerSwatch,
  };

  Color _getTypeColor(ToastType type) =>
      _typeColors[type] ?? Color(Colors.grey.shade300.value);

  static const Map<ToastType, IconData> _typeIcons = {
    ToastType.success: Icons.check_circle_outline_outlined,
    ToastType.warning: Icons.warning_amber_outlined,
    ToastType.info: Icons.info_outlined,
    ToastType.error: Icons.error_outline_outlined,
  };

  IconData _getTypeIcon(ToastType type) => _typeIcons[type] ?? Icons.info;
}
