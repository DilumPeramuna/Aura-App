import 'package:flutter/material.dart';
import 'package:aura1/models/product_model.dart';
import 'package:aura1/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
    } catch (e) {
      print("Error in ProductProvider: $e");
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
