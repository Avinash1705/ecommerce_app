import 'dart:convert';

import 'package:ecommerce_app/common/big_text.dart';
import 'package:ecommerce_app/common/small_text.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart%20';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/app_icon.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    //some logic on date filter
    Map<String ,int > cartItemsPerOrder = Map();
    for(int i=0 ; i< getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }
      else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    print("img check"+jsonEncode(getCartHistoryList).toString());
    List<int> itemsPerOrder = cartOrderTimeToList();
    var listCounter = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height30*4,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon :Icons.shopping_cart_outlined)
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for(int i=0; i< itemsPerOrder.length;i++)
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ((){
                              DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].time.toString());
                              var inputDate = DateTime.parse(parseDate.toString());
                              var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
                              var outputDate = outputFormat.format(inputDate);
                                return Text(outputDate);
                              // return Text(DateFormat.yMMMd().format(getCartHistoryList[listCounter].time));
                            }()),
                            SizedBox(height: Dimensions.height10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if(listCounter < getCartHistoryList.length){
                                      listCounter++;
                                    }
                                   return index <= 2?Container(
                                     height: Dimensions.height20*4,
                                     width: Dimensions.width20*4,
                                     margin: EdgeInsets.only(right: Dimensions.width10/2),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(Dimensions.radius30/2),
                                         image: DecorationImage(
                                             image: NetworkImage(
                                                 Constants.baseUrl+Constants.uploadUrl+getCartHistoryList[listCounter-1].product!.img.toString()
                                             )
                                         )
                                     ),

                                   ):Container() ;
                                  }),
                                ),
                                Container(
                                  height: Dimensions.height20*4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SmallText(text: "Total",color: AppColors.titleColor,),
                                      BigText(text: itemsPerOrder[i].toString()+"  Items",color: AppColors.titleColor,),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius30/2),
                                          border: Border.all(width: 1,color: AppColors.mainColor),
                                        ),
                                        child: SmallText(text: "one more",color: AppColors.mainColor),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                            
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
