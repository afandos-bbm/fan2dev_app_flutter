import 'package:equatable/equatable.dart';
import 'package:fan2dev/features/backoffice/data/data.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/features/contact/domain/entities/contact_form/contact_form.dart';
import 'package:fan2dev/utils/errors/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'backoffice_cubit_state.dart';

class BackofficeCubit extends Cubit<BackofficeCubitState> {
  BackofficeCubit({
    required this.backofficeFirestoreRemoteDataSource,
  }) : super(const BackofficeCubitState());

  final BackofficeFirestoreRemoteDataSource backofficeFirestoreRemoteDataSource;

  void init() {
    getContactForms();
    getBlogPosts();
  }

  Future<void> getContactForms() async {
    emit(state.copyWith(state: BackofficeCubitStates.loading));
    final result = await backofficeFirestoreRemoteDataSource.getContactForms();
    result.when(
      success: (contactForms) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: contactForms,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: [],
          ),
        );
      },
    );
  }

  Future<void> deleteContactForm(String id) async {
    emit(state.copyWith(state: BackofficeCubitStates.loading));
    final result =
        await backofficeFirestoreRemoteDataSource.deleteContactForm(id);
    result.when(
      success: (_) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: state.contactForms
                .where((contactForm) => contactForm.id != id)
                .toList(),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: state.contactForms
                .where((contactForm) => contactForm.id != id)
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> getBlogPosts() async {
    emit(
      BackofficeCubitState(
        state: BackofficeCubitStates.loading,
        posts: state.posts,
      ),
    );

    final result = await backofficeFirestoreRemoteDataSource.getBlogPosts();

    result.when(
      success: (data) {
        emit(
          BackofficeCubitState(
            state: BackofficeCubitStates.loaded,
            posts: data,
          ),
        );
      },
      failure: (error) {
        emit(
          BackofficeCubitState(
            state: BackofficeCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        emit(
          const BackofficeCubitState(
            state: BackofficeCubitStates.loaded,
          ),
        );
      },
    );
  }

  Future<void> toggleHidePost(String id) async {
    emit(state.copyWith(state: BackofficeCubitStates.loading));

    final post = state.posts.firstWhere((post) => post.id == id);
    final updatedPost = post.copyWith(isHidden: !post.isHidden);

    final result = await backofficeFirestoreRemoteDataSource
        .toggleHidePost(updatedPost.id);

    result.when(
      success: (_) {
        final updatedPosts = state.posts.map((post) {
          if (post.id == id) {
            return updatedPost;
          }
          return post;
        }).toList();

        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            posts: updatedPosts,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        final updatedPosts = state.posts.map((post) {
          if (post.id == id) {
            return updatedPost;
          }
          return post;
        }).toList();

        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            posts: updatedPosts,
          ),
        );
      },
    );
  }

  Future<void> editPostInternal(BlogPost post) async {
    emit(
      state.copyWith(
        post: post,
      ),
    );
  }

  Future<void> editPost() async {
    final post = state.post!;

    emit(state.copyWith(state: BackofficeCubitStates.loading));

    final result = await backofficeFirestoreRemoteDataSource.editPost(post);

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            posts: state.posts.map((p) {
              if (p.id == post.id) {
                return post;
              }
              return p;
            }).toList(),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            posts: state.posts.map((p) {
              if (p.id == post.id) {
                return post;
              }
              return p;
            }).toList(),
          ),
        );
      },
    );
  }
}
