import 'package:ecommerce_app/controllers/cart_controller.dart';

import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositary/popular_products_repo.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class PopularProductController extends GetxController {
  final PopularProductsRepo popularProductsRepo;

  //init
  PopularProductController({required this.popularProductsRepo});

  List<Products> _popularProductList = [];
  late CartController _cartController;

  // List<dynamic> getterPopularProductList(){
  //   return _popularProductList;
  // }
  bool _isLoading = false;

  int _quantity = 0;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  int get quantity => _quantity;

  bool get isLoading => _isLoading;

  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductsRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got result");
      _popularProductList = [];
      _popularProductList
          .addAll(ProductModel.fromJson(response.body).products!);
      _isLoading = true;
      update();
    } else {
      print("else ${response.statusCode}");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("increment $_quantity");
    } else {
      // _quantity -= 1;

      _quantity = checkQuantity(_quantity - 1);
      print("decrement $_quantity");
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "U can't reduce more",
          colorText: Colors.white, backgroundColor: AppColors.mainColor);
      if(_inCartItems >0){
        _quantity = - _inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "U can't add more",
          colorText: Colors.white, backgroundColor: AppColors.mainColor);

      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(Products product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    // if exist call from storage _inCartItems
    var exist = false;
    exist = _cartController.existInCart(product);
    if (exist) {
      _inCartItems = cartController.getQuantity(product);
    }
  }

  void addItem(Products product) {
    _cartController.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);
    Get.snackbar("Item Count", "Added",
        colorText: Colors.white, backgroundColor: AppColors.mainColor);
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
