import 'package:ecommerce_app/ui/cart/cart_page.dart';
import 'package:ecommerce_app/ui/food/popular_food_detail.dart';
import 'package:ecommerce_app/ui/home/home_page.dart';
import 'package:ecommerce_app/ui/home/main_food_page.dart';
import 'package:ecommerce_app/ui/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/food/recommended_food_detail.dart';

class RoutesHelper {
  static const String splash = "/splashScreen";
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = "/cart-page";

  // for arguments
  static String getInitial() => '$initial';
  static String getSplashPage() => '$splash';
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int index,String page) => '$recommendedFood?index=$index&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    // GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail( pageId: int.parse(pageId!),page:page!);
    }),
    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['index'];
      var page = Get.parameters['page'];
      return RecomendedFoodDetail(pageId: int.parse(pageId!),page:page!) ;
  } ),
    GetPage(name: cartPage, page: () => CartPage()  ,transition: Transition.fadeIn)
  ];
}