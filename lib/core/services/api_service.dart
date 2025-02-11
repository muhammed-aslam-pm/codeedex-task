import 'dart:convert';
import 'package:codeedex_machinetest/core/constents/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}'),
        body: {
          'email': email,
          'password': password,
        },
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
