part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String error;

  const ProductErrorState(this.error);
}
