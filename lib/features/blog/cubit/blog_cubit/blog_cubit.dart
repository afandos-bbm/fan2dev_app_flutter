import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:fan2dev/features/blog/data/data_sources/blog_firestore_remote_data_source.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/utils/errors/error.dart';
import 'package:fan2dev/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_cubit_state.dart';

class BlogCubit extends Cubit<BlogCubitState> {
  BlogCubit({
    required this.blogFirestoreRemoteDataSource,
  }) : super(const BlogCubitState());

  final BlogFirestoreRemoteDataSource blogFirestoreRemoteDataSource;
  final int postPageLimit = 10;

  Future<void> getPosts({
    BlogPostCategory category = BlogPostCategory.all,
  }) async {
    final lastCategory = state.category;
    if (lastCategory != category) {
      emit(
        BlogCubitState(
          state: BlogCubitStates.loading,
          category: category,
        ),
      );
    } else {
      emit(
        BlogCubitState(
          state: BlogCubitStates.loading,
          posts: state.posts,
          postsPagination: state.postsPagination,
          category: category,
        ),
      );
    }

    final result = await blogFirestoreRemoteDataSource.getPosts(
      start: state.postsPagination + postPageLimit,
      limit: postPageLimit,
      category: category,
    );

    result.when(
      success: (data) {
        if (data.length < postPageLimit) {
          emit(
            BlogCubitState(
              state: BlogCubitStates.reachedMax,
              posts: state.posts + data,
              postsPagination: state.postsPagination + postPageLimit,
              category: category,
            ),
          );
          return;
        }

        emit(
          BlogCubitState(
            state: BlogCubitStates.loaded,
            posts: state.posts + data,
            postsPagination: state.postsPagination + postPageLimit,
            category: category,
          ),
        );
      },
      failure: (error) {
        emit(
          BlogCubitState(
            state: BlogCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
          ),
        );
      },
      empty: () {
        emit(
          const BlogCubitState(
            state: BlogCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: 'No data',
            ),
          ),
        );
      },
    );
  }

  Future<void> getPostById({required String id}) async {
    emit(
      const BlogCubitState(
        state: BlogCubitStates.loading,
      ),
    );

    final result = await blogFirestoreRemoteDataSource.getPostById(id: id);

    result.when(
      success: (data) {
        emit(
          BlogCubitState(
            state: BlogCubitStates.loaded,
            post: data,
          ),
        );
      },
      failure: (error) {
        emit(
          BlogCubitState(
            state: BlogCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
          ),
        );
      },
      empty: () {
        emit(
          const BlogCubitState(
            state: BlogCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: 'No data',
            ),
          ),
        );
      },
    );
  }

  Future<void> toggleLike(BlogPost post) async {
    final previousState = state.state;

    emit(
      BlogCubitState(
        state: BlogCubitStates.loading,
        post: post,
        posts: state.posts,
      ),
    );

    final Result<void, Exception> result;
    if (post.isLikedByUser) {
      result = await blogFirestoreRemoteDataSource.unlikePost(id: post.id);
    } else {
      result = await blogFirestoreRemoteDataSource.likePost(id: post.id);
    }

    result.when(
      success: (_) {
        final postsLiked = locator<SharedPreferencesService>().postsLiked;
        if (post.isLikedByUser) {
          locator<SharedPreferencesService>().postsLiked = postsLiked
            ..remove(post.id);
          emit(
            BlogCubitState(
              state: previousState,
              post: post.copyWith(likes: post.likes - 1),
              posts: state.posts.map((e) {
                if (e.id == post.id) {
                  return post.copyWith(likes: post.likes - 1);
                }
                return e;
              }).toList(),
            ),
          );
        } else {
          locator<SharedPreferencesService>().postsLiked = postsLiked
            ..add(post.id);
          emit(
            BlogCubitState(
              state: previousState,
              post: post.copyWith(likes: post.likes + 1),
              posts: state.posts.map((e) {
                if (e.id == post.id) {
                  return post.copyWith(likes: post.likes + 1);
                }
                return e;
              }).toList(),
            ),
          );
        }
      },
      failure: (error) {
        emit(
          BlogCubitState(
            state: BlogCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
          ),
        );
      },
      empty: () {
        final postsLiked = locator<SharedPreferencesService>().postsLiked;
        if (post.isLikedByUser) {
          locator<SharedPreferencesService>().postsLiked = postsLiked
            ..remove(post.id);
          emit(
            BlogCubitState(
              state: previousState,
              post: post.copyWith(likes: post.likes - 1),
              posts: state.posts.map((e) {
                if (e.id == post.id) {
                  return post.copyWith(likes: post.likes - 1);
                }
                return e;
              }).toList(),
            ),
          );
        } else {
          locator<SharedPreferencesService>().postsLiked = postsLiked
            ..add(post.id);
          emit(
            BlogCubitState(
              state: previousState,
              post: post.copyWith(likes: post.likes + 1),
              posts: state.posts.map((e) {
                if (e.id == post.id) {
                  return post.copyWith(likes: post.likes + 1);
                }
                return e;
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
