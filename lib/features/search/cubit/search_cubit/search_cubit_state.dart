part of 'search_cubit.dart';

enum SearchCubitStatuses { initial, loading, loaded, error }

@immutable
class SearchCubitState extends Equatable {
  const SearchCubitState({
    this.query = '',
    this.posts = const [],
    this.status = SearchCubitStatuses.initial,
    this.error,
  });

  final String query;
  final List<BlogPost> posts;
  final SearchCubitStatuses status;
  final Exception? error;

  SearchCubitState copyWith({
    String? query,
    List<BlogPost>? posts,
    SearchCubitStatuses? status,
    Exception? error,
  }) {
    return SearchCubitState(
      query: query ?? this.query,
      posts: posts ?? this.posts,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object> get props => [query, posts, status];
}
