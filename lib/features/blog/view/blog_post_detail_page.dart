import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/utils/extensions/datetime_extensions.dart';
import 'package:fan2dev/utils/result.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:flutter/material.dart';

class BlogPostDetailPage extends StatelessWidget {
  const BlogPostDetailPage({
    required this.post,
    super.key,
  });

  final Future<Result<BlogPost, Exception>> post;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<BlogPost, Exception>>(
      future: post,
      builder: (context, snapshot) {
        snapshot.data?.when(
          failure: (failure) {
            return Center(
              child: Text(failure.toString()),
            );
          },
          success: (post) {
            return Scaffold(
              appBar: AppBar(
                title: Text(post.title),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style:
                                context.currentTheme.textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.createdAt.toLocal().toFormattedString,
                            style: context.currentTheme.textTheme.bodySmall!
                                .copyWith(
                              color: context.themeColors.onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.content,
                            style: context.currentTheme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          empty: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        return const SizedBox();
      },
    );
  }
}