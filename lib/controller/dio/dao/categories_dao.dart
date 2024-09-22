import 'package:bioreino_mobile/controller/dio/dio_client.dart';
import 'package:bioreino_mobile/model/category.dart';
import 'package:flutter/material.dart';

class CategoriesDAO {
  static final List<Category> categories = [];

  static String _getEndpoint([String? endpoint]) {
    return "categories/${endpoint ?? ''}";
  }

  static Future<List<Category>> getCategories(BuildContext context) async {
    if (categories.isNotEmpty) return categories;
    final response = await DioClient().get(_getEndpoint());
    if (response == null) return [];
    if (response.statusCode != 200) return [];
    response.data.forEach((category) => categories.add(Category(category)));
    return categories;
  }
}
