import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/repositary/popular_products_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductsRepo popularProductsRepo;

  //init
  PopularProductController({required this.popularProductsRepo});

  List<Products> _popularProductList = [];

  // List<dynamic> getterPopularProductList(){
  //   return _popularProductList;
  // }
  bool _isLoading = false ;
  bool  get isLoading => _isLoading;
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductsRepo.getPopularProductList();
    if(response.statusCode ==200 ){

      print("got result");
      _popularProductList = [];
      _popularProductList.addAll(ProductModel.fromJson(response.body).products!);
      print(Constants.baseUrl+Constants.uploadUrl+_popularProductList[0].img!);
      _isLoading = true ;
      update();
    }
    else {
      print("else ${response.statusCode}");
    }
  }
}
