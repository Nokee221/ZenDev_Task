import 'dart:convert';

import 'package:zendev_task/src/features/products/domain/repositories/product_repository.dart';
import 'package:zendev_task/src/shared/data/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl implements ProductRepository {
  final String apiUrl = "https://fakestoreapi.com/products";

  @override
  Future<List<Product>> getProducts() async {
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).take(10).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    var response = await http.get(Uri.parse('$apiUrl/category/$category'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<void> deleteProduct(int productId) async {
    final response =
        await http.delete(Uri.parse('$apiUrl/$productId'));

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete product: ${response.statusCode}');
    }
  }

  @override
  Future<void> editProduct(Product product) async {
    var apiUrlWithId = '$apiUrl/${product.id}';

    String productJson = json.encode(product.toJson());

    var response = await http.put(
      Uri.parse(apiUrlWithId),
      headers: {
        'Content-Type': 'application/json',
      },
      body: productJson,
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to edit product: ${response.statusCode}');
    }
  }
}
