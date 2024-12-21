import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/services/product_service.dart';

import '../models/banner_list_item_model.dart';
import '../models/category_list_item_model.dart';
import '../models/home_screen_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  final ProductService _productService = ProductService();
  final HomeScreenModel homeScreenModel = HomeScreenModel();

  bool isDataloaded = false;

  // Hàm load tất cả dữ liệu từ Firestore
  Future<void> loadAllData() async {
    try {
      if (isDataloaded == false) {
        print('data da load xog ');
        List<Product> _allProducts = await _productService.fetchAllProducts();
        homeScreenModel.setAllProducts(_allProducts);
        List<Product> _trendingProducts =
            await _productService.getTrendingProducts();
        List<Product> _saleProducts =
            await _productService.getSaleProductList();
        List<Product> _recommendedProducts =
            await _productService.fetchAllProducts();
        homeScreenModel.setTrendingProductList(_trendingProducts);
        homeScreenModel.setSaleProductList(_saleProducts);

        isDataloaded = true;
      }
      notifyListeners();
    } catch (e) {
      print('Error loading data: $e');
      notifyListeners();
      throw e; // Xử lý lỗi ở nơi gọi
    }
  }

  Future<void> loadRecommendProductList() async {
    try {
      List<Product> _recommendedProducts =
          await _productService.fetchAllProducts();
      homeScreenModel.setRecommendProductList(_recommendedProducts);

      notifyListeners();
    } catch (e) {
      print('Error loading data: $e');
      notifyListeners();
      throw e; // Xử lý lỗi ở nơi gọi
    }
  }

  List<Product> filterProducts(String query) {
    if (query.isEmpty) {
      return [];
    } else {
      return homeScreenModel.allProducts.where((product) {
        return product.product_name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  int sliderIndex = 0;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void changeSliderIndex(int value) {
    sliderIndex = value;
    notifyListeners();
  }
}
