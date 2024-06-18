import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/blog/cubit/cubit.dart';
import 'package:fan2dev/features/blog/view/widgets/blog_post_comments_footer.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> blogPostCommentsDialog(
  BuildContext context,
  BlogCubit cubit,
) async {
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: cubit,
        child: const _BlogPostCommentsDialogView(),
      );
    },
  );
}

class _BlogPostCommentsDialogView extends StatelessWidget {
  const _BlogPostCommentsDialogView();

  @override
  Widget build(BuildContext context) {
    context
        .read<BlogCubit>()
        .getPostComments(postId: context.read<BlogCubit>().state.post!.id);
    return ColorfulSafeArea(
      color: locator<ThemeService>().isLightMode
          ? context.currentTheme.colorScheme.background
          : Colors.black,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Scaffold(
          bottomNavigationBar: BlogPostCommentsFooter(),
          backgroundColor: context.currentTheme.colorScheme.background,
          appBar: AppBar(
            title: Text(
              context.l10n.blog_post_comments_title,
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: context.themeColors.onBackground,
            titleTextStyle: context.currentTheme.textTheme.titleLarge!.copyWith(
              color: context.themeColors.onBackground,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: context.themeColors.onBackground,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: BlocBuilder<BlogCubit, BlogCubitState>(
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

              if (state.postComments.isEmpty) {
                return Center(
                  child: Text(context.l10n.blog_post_comments_empty),
                );
              }

              return ListView.builder(
                itemCount: state.postComments.length,
                itemBuilder: (context, index) {
                  final comment = state.postComments[index];
                  return ListTile(
                    title: Text(comment.authorDisplayName),
                    subtitle: Text(comment.content),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
