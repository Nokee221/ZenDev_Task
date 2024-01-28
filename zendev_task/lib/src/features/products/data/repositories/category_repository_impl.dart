import 'dart:convert';

import 'package:zendev_task/src/features/products/domain/repositories/category_repostiory.dart';
import 'package:http/http.dart' as http;

class CategoryRepositoryImpl implements CategoryRepository {
  final String apiUrl = "https://fakestoreapi.com/products/categories";

  @override
  Future<List<String>> getCategory() async {
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> categories = List<String>.from(data);

      categories.insert(0, "all");

      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
