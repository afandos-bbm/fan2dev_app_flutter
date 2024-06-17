import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/view/widgets/blog_post_action_widget.dart';
import 'package:fan2dev/utils/extensions/datetime_extensions.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        late Widget child;

        snapshot.data?.when(
          failure: (failure) {
            child = Center(
              child: Text(failure.toString()),
            );
          },
          success: (post) {
            child = Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/blog');
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: Text(
                          post.createdAt.toLocal().toFormattedString,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            post.title,
                            style:
                                context.currentTheme.textTheme.headlineMedium,
                          ),
                        ),
                        Markdown(
                          data: post.content.removeLineBreaks,
                          shrinkWrap: true,
                          selectable: true,
                          softLineBreak: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          empty: () {
            child = const Center(
              child: Text('No data'),
            );
          },
        );

        return child;
      },
    );
  }
}
