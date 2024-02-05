import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/blog/cubit/cubit.dart';
import 'package:fan2dev/features/blog/data/data_sources/blog_firestore_remote_data_source.dart';
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
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.content),
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
