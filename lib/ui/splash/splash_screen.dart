import 'dart:async';

import 'package:ecommerce_app/controllers/login_controller.dart';
import 'package:ecommerce_app/routes/routes_helper.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart%20';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;
  late bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkUserAlreadyLogin().then((value) => isLogin = value);
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    Timer(
        Duration(seconds: 3),
        () => isLogin
            ? Get.offNamed(RoutesHelper.getInitial())
            : Get.offNamed(RoutesHelper.getLoginPage()));
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  Future<bool> checkUserAlreadyLogin() async {
    // Get.find<LoginController>().checkLogin();
    LoginController loginController = Get.find<LoginController>();
    if (loginController.sharedPreferencesLogin.getBool("isLogin") == null) {
      isLogin = false;
    } else {
      isLogin = loginController.sharedPreferencesLogin.getBool("isLogin")!;
    }
    return isLogin;
  }

  @override
  Widget build(BuildContext context) {
    _loadResources();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/images/food_splash.png",
              ))),
          SizedBox(
            height: 40,
          ),
          Image.asset(
            "assets/images/best_food.png",
          )
        ],
      ),
    );
  }
}
