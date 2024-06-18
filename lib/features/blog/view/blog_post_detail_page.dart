import 'package:fan2dev/features/blog/cubit/blog_cubit/blog_cubit.dart';
import 'package:fan2dev/features/blog/view/widgets/blog_post_action_widget.dart';
import 'package:fan2dev/features/blog/view/blog_post_comments_dialog.dart';
import 'package:fan2dev/utils/extensions/datetime_extensions.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class BlogPostDetailPage extends StatelessWidget {
  const BlogPostDetailPage({
    required this.postId,
    super.key,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCubit, BlogCubitState>(
      builder: (context, state) {
        if (state.status == BlogCubitStatuses.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == BlogCubitStatuses.error) {
          return Center(
            child: Text(
              state.error.toString(),
              style: context.currentTheme.textTheme.labelMedium,
            ),
          );
        }

        if (state.post == null) {
          return Center(
            child: Text(
              'Post not found',
              style: context.currentTheme.textTheme.labelMedium,
            ),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                state.post!.totalComments.toString(),
                                style:
                                    context.currentTheme.textTheme.labelSmall,
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.comment_rounded, size: 15),
                            ],
                          ),
                          onPressed: () async {
                            await blogPostCommentsDialog(
                              context,
                              context.read<BlogCubit>(),
                            );
                          },
                        ),
                        BlogPostActionsWidget(
                          post: state.post!,
                        ),
                      ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${state.post!.category.name.toUpperCase()} - ${state.post!.createdAt.toLocal().toFormattedString}',
                        style: context.currentTheme.textTheme.labelSmall,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        state.post!.title,
                        style: context.currentTheme.textTheme.headlineMedium,
                      ),
                    ),
                    Markdown(
                      data: state.post!.content.removeLineBreaks,
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
    );
  }
}
