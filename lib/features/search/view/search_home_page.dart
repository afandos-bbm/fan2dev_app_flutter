import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/features/search/cubit/search_cubit/search_cubit.dart';
import 'package:fan2dev/features/search/data/data_sources/search_firestore_remote_data_source.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchHomePage extends StatelessWidget {
  const SearchHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        searchFirestoreRemoteDataSource:
            locator<SearchFirestoreRemoteDataSource>(),
      )..search(''),
      child: const SearchHomePageView(),
    );
  }
}

class SearchHomePageView extends StatelessWidget {
  const SearchHomePageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: context.l10n.menu_search,
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (query) {
              context.read<SearchCubit>().search(query);
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<SearchCubit, SearchCubitState>(
            builder: (context, state) {
              if (state.status == SearchCubitStatuses.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == SearchCubitStatuses.error) {
                return const Text('Error');
              } else if (state.posts.isEmpty) {
                return const Center(child: Text('No results'));
              } else {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.posts.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return ListTile(
                        title: Text(post.title),
                        onTap: () {
                          context.push('/blog/${post.id}');
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
