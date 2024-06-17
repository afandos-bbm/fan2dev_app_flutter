import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:fan2dev/features/blog/cubit/blog_cubit/blog_cubit.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/toast_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class BlogPostActionsWidget extends StatelessWidget {
  const BlogPostActionsWidget({required this.post, super.key});

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Row(
            children: [
              Text(
                post.likes.toString(),
                style: context.currentTheme.textTheme.bodySmall!.copyWith(
                  color: post.isLikedByUser
                      ? context.themeColors.primary
                      : context.themeColors.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                post.isLikedByUser ? Icons.favorite : Icons.favorite_border,
                size: 15,
                color: post.isLikedByUser
                    ? context.themeColors.primary
                    : context.themeColors.onSurface.withOpacity(0.6),
              ),
            ],
          ),
          onPressed: () {
            context.read<BlogCubit>().toggleLike(post);
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, size: 15),
          onPressed: () {
            if (kIsWeb) {
              Clipboard.setData(ClipboardData(text: post.url));
              context.showToast(
                ToastModel(
                  message: context.l10n.global_copied_to_clipboard,
                  type: ToastType.info,
                ),
              );
            } else {
              Share.share(
                '${post.title}\n URL:${post.url}',
              );
            }
          },
        ),
      ],
    );
  }
}
