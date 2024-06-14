part of 'backoffice_cubit.dart';

enum BackofficeCubitStates { initial, loading, loaded, error, reachedMax }

class BackofficeCubitState extends Equatable {
  const BackofficeCubitState({
    this.state = BackofficeCubitStates.initial,
    this.posts = const [],
    this.contactForms = const [],
    this.post,
    this.error,
  });

  final BackofficeCubitStates state;
  final List<BlogPost> posts;
  final List<ContactForm> contactForms;
  final BlogPost? post;
  final AppError? error;

  BackofficeCubitState copyWith({
    BackofficeCubitStates? state,
    List<BlogPost>? posts,
    List<ContactForm>? contactForms,
    BlogPost? post,
    AppError? error,
  }) {
    return BackofficeCubitState(
      state: state ?? this.state,
      posts: posts ?? this.posts,
      contactForms: contactForms ?? this.contactForms,
      post: post ?? this.post,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [state, posts, post, error];
}
