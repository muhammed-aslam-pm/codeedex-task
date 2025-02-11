import 'dart:convert';
import 'dart:developer';
import 'package:codeedex_machinetest/core/constents/api_constants.dart';
import 'package:codeedex_machinetest/models/product_model.dart';
import 'package:http/http.dart' as http;

/// Custom exception for handling API-specific errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}';
}

/// Service class responsible for handling all API communications
class ApiService {
  final http.Client client;
  ApiService({http.Client? client}) : client = client ?? http.Client();

  /// Authenticates a user with their email and password
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}'),
        headers: _getHeaders(),
        body: json.encode(_getLoginBody(email, password)),
      );

      final decodedResponse = json.decode(response.body);

      if (response.statusCode != 200) {
        throw ApiException(
          decodedResponse['message'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }

      return decodedResponse;
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Failed to login: $e');
    }
  }

  /// Fetches products with pagination support
  Future<Map<String, dynamic>> fetchProducts({String? nextPageUrl}) async {
    try {
      final url =
          nextPageUrl ?? '${ApiConstants.baseUrl}${ApiConstants.products}';
      final response = await client.get(Uri.parse(url));

      log('Product fetch status code: ${response.statusCode}');
      log('Product fetch response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'products': ProductModel.fromJsonList(data['results']),
          'nextPage': data['next'],
        };
      }

      throw ApiException(
        'Failed to load products',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Failed to fetch products: $e');
    }
  }

  /// Fetches detailed information for a specific product
  Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}$productId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      }

      throw ApiException(
        'Failed to load product details',
        statusCode: response.statusCode,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Failed to fetch product details: $e');
    }
  }

  /// Returns the standard headers used in API requests
  Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
      };

  /// Returns the body for login request
  Map<String, String> _getLoginBody(String email, String password) => {
        'email': email,
        'password': password,
      };
}
