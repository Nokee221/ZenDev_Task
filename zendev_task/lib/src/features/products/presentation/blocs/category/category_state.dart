part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<String> categories;

  const CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final String error;

  const CategoryErrorState(this.error);
}
