import 'package:zendev_task/src/shared/data/models/products_model.dart';

abstract class ProductRepository{
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<void> deleteProduct(int productId);
  Future<void> editProduct(Product product);
}