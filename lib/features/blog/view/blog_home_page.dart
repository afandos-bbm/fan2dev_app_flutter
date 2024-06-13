import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/blog/cubit/cubit.dart';
import 'package:fan2dev/features/blog/data/data_sources/blog_firestore_remote_data_source.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/features/blog/view/widgets/blog_post_item.dart';
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
                itemCount: BlogPostCategory.values.length,
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
                        ],
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
                'Posts',
                style: context.currentTheme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: PaginatedListView(
                itemCount: state.posts.length,
                hasReachedMax: state.state == BlogCubitStates.reachedMax,
                onFetchData: () {
                  context.read<BlogCubit>().getPosts();
                },
                errorBuilder: (context) {
                  return const GenericErrorWidget();
                },
                isError: state.state == BlogCubitStates.error,
                loadingBuilder: (context) {
                  return const LoadingWidget();
                },
                isLoading: state.state == BlogCubitStates.loading,
                padding: const EdgeInsets.all(20),
                emptyBuilder: (context) {
                  return const Center(
                    child: Column(
                      children: [
                        Icon(Icons.info),
                        Text('No posts found'),
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
