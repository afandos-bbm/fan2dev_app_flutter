part of 'blog_cubit.dart';

enum BlogCubitStatuses { initial, loading, loaded, error, reachedMax }

class BlogCubitState extends Equatable {
  const BlogCubitState({
    this.status = BlogCubitStatuses.initial,
    this.category = BlogPostCategory.all,
    this.posts = const [],
    this.postsPagination = 0,
    this.post,
    this.postComments = const [],
    this.error,
  });

  final BlogCubitStatuses status;
  final List<BlogPost> posts;
  final BlogPostCategory category;
  final int postsPagination;
  final BlogPost? post;
  final List<BlogPostComment> postComments;
  final AppError? error;

  @override
  List<Object?> get props =>
      [status, posts, category, postsPagination, post, postComments, error];

  BlogCubitState copyWith({
    BlogCubitStatuses? status,
    List<BlogPost>? posts,
    BlogPostCategory? category,
    int? postsPagination,
    BlogPost? post,
    List<BlogPostComment>? postComments,
    AppError? error,
  }) {
    return BlogCubitState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      category: category ?? this.category,
      postsPagination: postsPagination ?? this.postsPagination,
      post: post ?? this.post,
      postComments: postComments ?? this.postComments,
      error: error,
    );
  }
}
