import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'http://localhost:8080/api'; // Replace with your API base URL

  // GET request with optional query params
  Future<http.Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(uri);
    return response;
  }

  // POST request with optional body params
  Future<http.Response> post({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }

  // PUT request with optional body params
  Future<http.Response> put({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }

  // DELETE request with optional query params
  Future<http.Response> delete({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParams);
    final response = await http.delete(uri);
    return response;
  }
}
