import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';

class BlogPostChipWidget extends StatelessWidget {
  const BlogPostChipWidget({
    required this.category,
    super.key,
  });

  final BlogPostCategory category;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category.name,
        style: context.currentTheme.textTheme.labelSmall,
      ),
      backgroundColor: context.currentTheme.primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: BorderSide.none,
    );
  }
}
