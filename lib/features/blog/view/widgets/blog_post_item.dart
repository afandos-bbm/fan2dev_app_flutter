import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/view/widgets/blog_post_chip_widget.dart';
import 'package:fan2dev/utils/extensions/datetime_extensions.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogPostItem extends StatelessWidget {
  const BlogPostItem({
    required this.post,
    super.key,
  });

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/blog/${post.id}', extra: post);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: ResponsiveWidget.isMobile(context) ? 210 : 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlogPostChipWidget(
                category: post.category,
              ),
              const SizedBox(height: 5),
              Text(
                post.title,
                style: context.currentTheme.textTheme.headlineSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              Text(
                post.subtitle,
                style: context.currentTheme.textTheme.bodySmall!.copyWith(
                  color: context.themeColors.onSurface.withOpacity(0.6),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: false,
                strutStyle: const StrutStyle(
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                post.createdAt.toLocal().toFormattedString,
                style: context.currentTheme.textTheme.bodySmall!.copyWith(
                  color: context.themeColors.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
