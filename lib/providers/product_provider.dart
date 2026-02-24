import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Product> products = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      products = await _api.fetchProducts();
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}