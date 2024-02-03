import 'dart:convert';

import 'package:ecommerce_app/base/no_data_page.dart';
import 'package:ecommerce_app/common/app_icon.dart';
import 'package:ecommerce_app/common/big_text.dart';
import 'package:ecommerce_app/common/small_text.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app/ui/home/main_food_page.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../routes/routes_helper.dart';
import '../../utils/colors.dart';
import '../paypal/payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20 * 5),
                    GestureDetector(
                      onTap: () => Get.toNamed(RoutesHelper.initial),
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController){
              return _cartController.getItems.length > 0?Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    // color: Colors.deepOrange,
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child:
                        GetBuilder<CartController>(builder: (cartController) {
                          var _cartList = cartController.getItems;
                          // print("cartItems ${jsonEncode(cartController.getItems[1].product!.img)}");
                          return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  height: 100,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(bottom: 10),
                                  // color: Colors.blue,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                              _cartList[index].product);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RoutesHelper.getPopularFood(
                                                    popularIndex, "cartpage"));
                                          }

                                          else {
                                            var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                _cartList[index].product!);
                                            if(recommendedIndex <0){
                                              Get.snackbar("History Product", "Product review is not available for history products",backgroundColor: AppColors.mainColor,colorText: Colors.white);
                                            }
                                            else{
                                              Get.toNamed(
                                                  RoutesHelper.getRecommendedFood(
                                                      recommendedIndex,
                                                      "cartpage"));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radius20)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      Constants.baseUrl +
                                                          Constants.uploadUrl+cartController.getItems[index].product!.img.toString()),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: Dimensions.height20 * 6,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SmallText(
                                                    text: "Spicy",
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text:
                                                        "\$ ${cartController.getItems[index].product!.price!}",
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: Dimensions.width10,
                                                            right: Dimensions.width10,
                                                            top: Dimensions.height10,
                                                            bottom:
                                                            Dimensions.height10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                            color: Colors.white),
                                                        child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color:
                                                                AppColors.signColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                              Dimensions.width20 /
                                                                  2,
                                                            ),
                                                            BigText(
                                                                text: _cartList[index]
                                                                    .quantity
                                                                    .toString()),
                                                            SizedBox(
                                                              width:
                                                              Dimensions.width20 /
                                                                  2,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color:
                                                                AppColors.signColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              });
                        })),
                  )):NoDataPage(text: "Your Cart is empty !");
            },
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2)),
              ),
              child: cartController.getItems.length > 0 ?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10,
                        right: Dimensions.width10,
                        top: Dimensions.height10,
                        bottom: Dimensions.height10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20/2),
                        color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.width20 / 2,
                        ),
                        BigText(text: "\$ ${cartController.totalAmount}"),
                        SizedBox(
                          width: Dimensions.width20 / 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10,
                        right: Dimensions.width10,
                        top: Dimensions.height10,
                        bottom: Dimensions.height10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20/2),
                        color: AppColors.mainColor),
                    child: GestureDetector(
                      onTap: () {
                        // popularProductController.addItem(product);
                        print("tapped checkout");
                        cartController.addToHistroy();
                        Get.to(PaymentPage(title: '',));
                      },
                      child: BigText(
                        text: "Checkout",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ):Container(),
            );
          },
        ));
  }
}
