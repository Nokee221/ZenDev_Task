import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zendev_task/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:zendev_task/src/shared/data/models/products_model.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryImpl _productRepository;

  ProductBloc({required ProductRepositoryImpl productRepository})
      : _productRepository = productRepository,
        super(ProductLoadingState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<DeleteProductsEvent>(_onDeleteProduct);
    on<EditProductsEvent>(_onEditProduct);
  }

  Future<void> _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      if (event.selectedCategory != null) {
        final List<Product> productList = await _productRepository
            .getProductsByCategory(event.selectedCategory!);
        if (event.searchString != null && event.searchString != "") {
          final filteredProductList = productList
              .where((product) => product.title
                  .toLowerCase()
                  .contains(event.searchString!.toLowerCase()))
              .toList();
          emit(ProductLoadedState(filteredProductList));
        } else {
          emit(ProductLoadedState(productList));
        }
      } else {
        final List<Product> productList =
            await _productRepository.getProducts();
        if (event.searchString != null && event.searchString != "") {
          final filteredProductList = productList
              .where((product) => product.title
                  .toLowerCase()
                  .contains(event.searchString!.toLowerCase()))
              .toList();
          emit(ProductLoadedState(filteredProductList));
        } else {
          emit(ProductLoadedState(productList));
        }
      }
    } catch (e) {
      emit(const ProductErrorState('Failed to fetch products'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.deleteProduct(event.producetId);
    } catch (e) {
      emit(const ProductErrorState('Failed to delete product'));
    }
  }

  Future<void> _onEditProduct(
      EditProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      await _productRepository.editProduct(event.product);
    } catch (e) {
      emit(const ProductErrorState('Failed to delete product'));
    }
  }
}
