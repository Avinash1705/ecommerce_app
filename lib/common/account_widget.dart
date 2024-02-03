import 'package:ecommerce_app/common/app_icon.dart';
import 'package:ecommerce_app/common/big_text.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart%20';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
      child: Row(
        children: [appIcon, SizedBox(width: Dimensions.width10,),bigText],
      ),
    );
  }
}
