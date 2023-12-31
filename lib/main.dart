import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app/helper/dependencies.dart' as dep;
import 'package:ecommerce_app/routes/routes_helper.dart';
import 'package:ecommerce_app/ui/food/recommended_food_detail.dart';
import 'package:ecommerce_app/ui/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();            //make sure dep is loaded
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      getPages: RoutesHelper.routes ,
      initialRoute: RoutesHelper.initial,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MainFoodPage(),
      home: MainFoodPage(),
    );
  }
}

