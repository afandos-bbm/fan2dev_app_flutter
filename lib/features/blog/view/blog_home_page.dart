import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/blog/cubit/cubit.dart';
import 'package:fan2dev/features/blog/data/data_sources/blog_firestore_remote_data_source.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/features/blog/view/widgets/blog_post_item.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/generic_error_widget.dart';
import 'package:fan2dev/utils/widgets/loading_widget.dart';
import 'package:fan2dev/utils/widgets/paginated_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogHomePage extends StatelessWidget {
  const BlogHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogCubit(
        blogFirestoreRemoteDataSource: locator<BlogFirestoreRemoteDataSource>(),
      )..getPosts(),
      child: const _BlogHomePageView(),
    );
  }
}

class _BlogHomePageView extends StatelessWidget {
  const _BlogHomePageView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCubit, BlogCubitState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                itemCount: BlogPostCategory.values.length - 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 4,
                    child: Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.themeColors.primary.withOpacity(0.1),
                      ),
                      child: InkWell(
                        onTap: () {
                          final selectedCategory = state.category;

                          if (selectedCategory ==
                              BlogPostCategory.values[index]) {
                            context.read<BlogCubit>().getPosts();
                            return;
                          }
                          context.read<BlogCubit>().getPosts(
                                category: BlogPostCategory.values[index],
                              );
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  BlogPostCategory.values[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 30,
                              right: 0,
                              child: Text(
                                BlogPostCategory.values[index].name,
                                style: context
                                    .currentTheme.textTheme.headlineSmall!
                                    .copyWith(
                                  color: Colors.white,
                                  shadows: [
                                    const Shadow(
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (state.category ==
                                BlogPostCategory.values[index])
                              Positioned(
                                top: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: context.themeColors.primary,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                context.l10n.blog_posts,
                style: context.currentTheme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: PaginatedListView(
                itemCount: state.posts.length,
                hasReachedMax: state.status == BlogCubitStatuses.reachedMax,
                onFetchData: () {
                  context.read<BlogCubit>().getPosts();
                },
                errorBuilder: (context) {
                  return const GenericErrorWidget();
                },
                isError: state.status == BlogCubitStatuses.error,
                loadingBuilder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const LoadingWidget(),
                  );
                },
                isLoading: state.status == BlogCubitStatuses.loading,
                padding: const EdgeInsets.all(20),
                emptyBuilder: (context) {
                  return Center(
                    child: Column(
                      children: [
                        const Icon(Icons.info),
                        Text(context.l10n.info_no_data),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(color: Colors.grey);
                },
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return BlogPostItem(
                    post: post,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
