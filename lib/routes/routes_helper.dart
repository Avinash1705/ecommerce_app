import 'package:ecommerce_app/ui/food/popular_food_detail.dart';
import 'package:ecommerce_app/ui/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/food/recommended_food_detail.dart';

class RoutesHelper {

  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';

  // for arguments
  static String getInitial() => '$initial';

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static String getRecommendedFood(int index) => '$recommendedFood?index=$index';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetail( pageId: int.parse(pageId!));
    }),
    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['index'];
      return RecomendedFoodDetail(pageId: int.parse(pageId!)) ;
  } ),
  ];
}