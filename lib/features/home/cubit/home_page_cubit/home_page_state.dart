part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    required this.index,
  });

  final int index;

  @override
  List<Object?> get props => [index];
}
