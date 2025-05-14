import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://sparefasta.co.tz/api';

  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body, {
    File? file,
    required Map<String, String> headers,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl$endpoint');
      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers.addAll(headers);

      // Add fields
      body.forEach((key, value) {
        if (value != null && key != 'profile_picture') {
          request.fields[key] = value.toString();
        }
      });

      // Add file if exists
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', // This should match your API's expected field name
          file.path,
        ));
      }

      var response = await http.Response.fromStream(await request.send());
      return response;
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }
}
