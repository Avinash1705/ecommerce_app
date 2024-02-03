import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/login_controller.dart';
import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app/data/api/api_client.dart';
import 'package:ecommerce_app/data/repositary/cart_repo.dart';
import 'package:ecommerce_app/data/repositary/popular_products_repo.dart';
import 'package:ecommerce_app/data/repositary/recommended_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

Future<void> init() async {
  // GetStorage.init();
  //api client
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);
  Get.lazyPut(() => ApiClient(appBaseUrl: Constants.baseUrl));

  //repo
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: sharedPreference));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductsRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductsRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LoginController(sharedPreferencesLogin: sharedPreference));
}
