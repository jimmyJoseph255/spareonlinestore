import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Base API URL with live domain
  final String _baseUrl = 'https://sparefasta.co.tz/api';

  // Perform a POST request securely
  Future<http.Response> post(String endpoint, Map<String, dynamic> body,
      {File? file, required Map<String, String> headers}) async {
    try {
      // Build the full URL
      final url = Uri.parse('$_baseUrl$endpoint');

      // Perform the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to perform POST request: $e');
    }
  }
}
