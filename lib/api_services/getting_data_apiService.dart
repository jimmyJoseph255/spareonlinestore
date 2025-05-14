import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://sparefasta.co.tz/api';

  // Fetch products by category ID
  static Future<List<dynamic>> fetchProductsByCategory({
    required int categoryId,
    String? token,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/show'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['products'] != null && data['products'] is List) {
        final products = data['products'] as List<dynamic>;

        // Filter products by category_id
        final categoryProducts = products.where((product) {
          final productCategoryId = product['category_id'] ?? 0;
          return productCategoryId == categoryId;
        }).toList();

        return categoryProducts;
      } else {
        throw Exception('Invalid response structure: missing products key.');
      }
    } else {
      throw Exception(
          'Failed to load products. Status code: ${response.statusCode}');
    }
  }

  // Helper methods for specific categories
  static Future<List<dynamic>> fetchTyreProducts({String? token}) async {
    return fetchProductsByCategory(categoryId: 1, token: token); // Tyres
  }

  static Future<List<dynamic>> fetchSideMirrorProducts({String? token}) async {
    return fetchProductsByCategory(categoryId: 4, token: token); // Side mirrors
  }

  static Future<List<dynamic>> fetchCarBatteryProducts({String? token}) async {
    return fetchProductsByCategory(
        categoryId: 7, token: token); // Car batteries — assuming category_id 7
  }

  static Future<List<dynamic>> fetchSuspensionProducts({String? token}) async {
    return fetchProductsByCategory(
        categoryId: 8, token: token); // Car batteries — assuming category_id 7
  }
}
