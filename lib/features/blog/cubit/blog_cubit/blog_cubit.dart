import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:fan2dev/features/blog/data/data_sources/blog_firestore_remote_data_source.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_comment.dart';
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
        state.copyWith(
          status: BlogCubitStatuses.loading,
          posts: [],
          postsPagination: 0,
          category: category,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BlogCubitStatuses.loading,
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
            state.copyWith(
              status: BlogCubitStatuses.reachedMax,
              posts: state.posts + data,
              postsPagination: state.postsPagination + postPageLimit,
              category: category,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: BlogCubitStatuses.loaded,
            posts: state.posts + data,
            postsPagination: state.postsPagination + postPageLimit,
            category: category,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
            posts: [],
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.reachedMax,
            posts: state.posts,
            postsPagination: state.postsPagination,
            category: category,
          ),
        );
      },
    );
  }

  Future<void> getPostById({required String id}) async {
    emit(
      state.copyWith(
        status: BlogCubitStatuses.loading,
      ),
    );

    final result = await blogFirestoreRemoteDataSource.getPostById(id: id);

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.loaded,
            post: data,
          ),
        );
      },
      failure: (error) {
        emit(
          BlogCubitState(
            status: BlogCubitStatuses.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.error,
            error: const BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: 'Post not found',
            ),
          ),
        );
      },
    );
  }

  Future<void> toggleLike(BlogPost post) async {
    final previousState = state.status;

    emit(
      state.copyWith(
        status: BlogCubitStatuses.loading,
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
            state.copyWith(
              status: previousState,
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
            state.copyWith(
              status: previousState,
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
          state.copyWith(
            status: previousState,
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
            state.copyWith(
              status: previousState,
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
            state.copyWith(
              status: previousState,
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

  Future<void> getPostComments({required String postId}) async {
    emit(
      state.copyWith(
        status: BlogCubitStatuses.loading,
      ),
    );

    final result = await blogFirestoreRemoteDataSource.getPostComments(
      postId: postId,
    );

    result.when(
      success: (data) {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.loaded,
            postComments: data,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.loaded,
            postComments: [],
          ),
        );
      },
    );
  }

  Future<void> addPostComment({
    required String postId,
    required String comment,
  }) async {
    emit(
      state.copyWith(
        status: BlogCubitStatuses.loading,
      ),
    );

    final result = await blogFirestoreRemoteDataSource.addPostComment(
      postId: postId,
      content: comment,
    );

    result.when(
      success: (comment) {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.loaded,
            postComments: state.postComments +
                [
                  comment,
                ],
            post: state.post!.copyWith(
              totalComments: state.post!.totalComments + 1,
            ),
            posts: state.posts.map((e) {
              if (e.id == postId) {
                return e.copyWith(
                  totalComments: e.totalComments + 1,
                );
              }
              return e;
            }).toList(),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            status: BlogCubitStatuses.error,
            error: const BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: 'Comment not added',
            ),
          ),
        );
      },
    );
  }

  Future<void> returnToPosts() async {
    await getPosts(category: state.category);
  }
}
