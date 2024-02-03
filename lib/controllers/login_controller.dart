import 'dart:convert';
import 'package:ecommerce_app/routes/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SharedPreferences sharedPreferencesLogin;

  LoginController({required this.sharedPreferencesLogin});

  Map<String, String> _userLoginDetail = Map();

  void checkLogin() {
    String username = usernameController.text.toString();
    String userpass = passwordController.text.toString();
    if (username == "Avinash" && userpass == "12345") {
      //success
      _userLoginDetail = {
        "userName": username,
        "userPassword": userpass,
      };
      // sharedPreferencesLogin.setString("userLoginDetail", jsonEncode(_userLoginDetail));
      sharedPreferencesLogin.setBool("isLogin", true);
      Get.offNamed(RoutesHelper.getInitial());
    } else if (username != "Avinash" || userpass != "12345") {
      Get.snackbar("Invalid User", "Please Check Ur credential",
          colorText: Colors.white, backgroundColor: AppColors.mainColor);
    } else {
      sharedPreferencesLogin.setBool("isLogin",false);
    }
  }
}
