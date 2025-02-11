import 'package:codeedex_machinetest/core/services/api_service.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _nextPageUrl;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    if (isLoadMore && (_nextPageUrl == null || _isLoading)) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.fetchProducts(nextPageUrl: _nextPageUrl);
      if (isLoadMore) {
        _products.addAll(result['products']);
      } else {
        _products = result['products'];
      }
      _nextPageUrl = result['nextPage'];
    } catch (e) {
      print("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
