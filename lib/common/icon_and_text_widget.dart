

import 'package:ecommerce_app/common/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  String text;
  IconData icon;
  Color iconColor ;

  IconAndTextWidget({Key? key,required this.icon ,required this.iconColor,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,),
        SizedBox(width: Dimensions.width5,),
        SmallText(text: text)
      ],
    );
  }
}
