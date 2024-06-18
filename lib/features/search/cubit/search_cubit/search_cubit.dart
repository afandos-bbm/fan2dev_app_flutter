import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post.dart';
import 'package:fan2dev/features/search/data/data_sources/search_firestore_remote_data_source.dart';
import 'package:flutter/widgets.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit({
    required this.searchFirestoreRemoteDataSource,
  }) : super(const SearchCubitState());

  final SearchFirestoreRemoteDataSource searchFirestoreRemoteDataSource;

  Future<void> search(String query) async {
    emit(
      state.copyWith(
        status: SearchCubitStatuses.loading,
        query: query,
      ),
    );

    final result =
        await searchFirestoreRemoteDataSource.searchPosts(query: query);

    result.when(
      success: (posts) {
        emit(
          state.copyWith(
            status: SearchCubitStatuses.loaded,
            posts: posts,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: SearchCubitStatuses.error,
            error: error,
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            status: SearchCubitStatuses.loaded,
            posts: [],
          ),
        );
      },
    );
  }
}
