part of 'blog_cubit.dart';

enum BlogCubitStates { initial, loading, loaded, error, reachedMax }

class BlogCubitState extends Equatable {
  const BlogCubitState({
    this.state = BlogCubitStates.initial,
    this.posts = const [],
    this.postsPagination = 0,
    this.post,
    this.error,
  });

  final BlogCubitStates state;
  final List<BlogPost> posts;
  final int postsPagination;
  final BlogPost? post;
  final AppError? error;

  @override
  List<Object?> get props => [state, posts, postsPagination, post, error];
}
