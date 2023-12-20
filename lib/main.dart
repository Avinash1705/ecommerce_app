import 'package:ecommerce_app/ui/food/popular_food_detail.dart';
import 'package:ecommerce_app/ui/food/recommended_food_detail.dart';
import 'package:ecommerce_app/ui/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MainFoodPage(),
      home: RecomendedFoodDetail(),
    );
  }
}

