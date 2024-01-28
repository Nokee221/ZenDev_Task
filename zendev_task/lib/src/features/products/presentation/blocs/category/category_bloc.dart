import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zendev_task/src/features/products/data/repositories/category_repository_impl.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepositoryImpl _categoryRepositoryImpl;

  CategoryBloc({required CategoryRepositoryImpl categoryRepositoryImpl})
      : _categoryRepositoryImpl = categoryRepositoryImpl,
        super(CategoryInitial()) {
    on<FetchCategoryEvent>(_onFetchCategory);
  }

  Future<void> _onFetchCategory(
      FetchCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    try {
      final List<String> productList =
          await _categoryRepositoryImpl.getCategory();

      emit(CategoryLoadedState(productList));
    } catch (e) {
      emit(const CategoryErrorState('Failed to fetch categories'));
    }
  }
}
