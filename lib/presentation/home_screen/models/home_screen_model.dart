import 'dart:async';

import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/services/product_service.dart';

import '../../../model/product.dart';

import 'banner_list_item_model.dart';
import 'category_list_item_model.dart';

class HomeScreenModel {
  final ProductService _productService = ProductService();



  List<BannerListItemModel>bannerList = [
    BannerListItemModel(image: "lib/assets/images/banner1.png"),
    BannerListItemModel(image: "lib/assets/images/banner2.png"),
  ];
  List<Product> allProducts = [];
  List<Product> trendingProductList = [];
  List<Product> saleProductList = [];
  List<Product> recommendProductList = [];

  bool isDataLoaded = false;
  void setAllProducts(List<Product> list) {
    allProducts = list;
  }
  void setTrendingProductList(List<Product> list) {
    trendingProductList = list;
  }
  void setSaleProductList(List<Product> list) {
    saleProductList = list;
  }
  void setRecommendProductList(List<Product> list) {
    recommendProductList = list;
  }




  // Future<void> loadAllData() async {
  //   if (!isDataLoaded) {
  //     allProducts = await _productService.fetchAllProducts();
  //     trendingProductList = await _productService.getTrendingProducts();
  //     saleProductList = await _productService.getSaleProductList();
  //     recommendProductList = allProducts.take(6).toList(); // Ví dụ lấy 6 sản phẩm đầu tiên
  //
  //     isDataLoaded = true; // Đánh dấu là đã tải xong dữ liệu
  //   }
  // }





  List<CategoryListItemModel> categoryList = [
    CategoryListItemModel(
        name: "Computer & Accessories",
        imageUrl: "lib/assets/icons/computer_and_accessories.svg"),
    CategoryListItemModel(
        name: "Home & Kitchen",
        imageUrl: "lib/assets/icons/home_and_kitchen.svg"),
    CategoryListItemModel(
        name: "Fashion & Apparel",
        imageUrl: "lib/assets/icons/fashion_and_apparel.svg"),
    CategoryListItemModel(
        name: "Groceries", imageUrl: "lib/assets/icons/groceries.svg"),
    CategoryListItemModel(name: "Toys", imageUrl: "lib/assets/icons/toys.svg"),
    CategoryListItemModel(
        name: "Books & Media",
        imageUrl: "lib/assets/icons/books_and_media.svg"),
  ];
}
