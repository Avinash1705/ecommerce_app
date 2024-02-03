import 'package:ecommerce_app/common/big_text.dart';
import 'package:ecommerce_app/controllers/login_controller.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../helper/dependencies.dart';
import '../../utils/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: AppColors.mainColor,
      //   title: const Text('Login Page'),
      // ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: Dimensions.screenHeight,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login2.jpg"),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            child: SingleChildScrollView(
              child: Container(
                width: 250,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: loginController.usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: loginController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        loginController.checkLogin();
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),

             Positioned(
               bottom: 100,
                left: 50,
                child: GestureDetector(
                  onTap: (){
                    Get.snackbar("In progress", "Will be added later",
                        colorText: Colors.white, backgroundColor: AppColors.mainColor);
                  },
                  child: SizedBox(
                    height: 25,
                    width: Dimensions.screenWidth,
                    child: BigText(text: "Don't have account click here",color: Colors.blue,),
                  ),
                )),
          // Container(
          //   width: 200,
          //   height: 200,
          //   color: Colors.blue,
          // ),
        ],
      ),
    );
  }
}
