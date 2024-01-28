part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  final String? selectedCategory;
  final String? searchString;

  const FetchProductsEvent({this.selectedCategory , this.searchString});
}

class DeleteProductsEvent extends ProductEvent {
  final int producetId;

  const DeleteProductsEvent({required this.producetId});
}

class EditProductsEvent extends ProductEvent {
  final Product product;

  const EditProductsEvent({required this.product});
}
