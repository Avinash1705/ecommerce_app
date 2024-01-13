import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/common/big_text.dart';
import 'package:ecommerce_app/common/icon_and_text_widget.dart';
import 'package:ecommerce_app/common/small_text.dart';
import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app/routes/routes_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../common/app_column.dart';
import '../../model/product_model.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoading
              ? Container(
                  // color: Colors.red,
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.isEmpty
                          ? 1
                          : popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }))
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        GetBuilder<PopularProductController>(
          builder: (popularProducts) =>
              popularProducts.popularProductList.isEmpty
                  ? CircularProgressIndicator()
                  : DotsIndicator(
                      dotsCount: popularProducts.popularProductList.length,
                      position: _currentPageValue.toInt(),
                      decorator: DotsDecorator(
                        activeColor: AppColors.mainColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
        ),
        //popular tags
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width30, top: Dimensions.height20),
          child: Row(
            children: [
              BigText(text: "Recommended "),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              ),
            ],
          ),
        ),
        //listview
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return ListView.builder(
              itemCount: recommendedProducts.recommendedProductList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: Dimensions.width5,
                        left: Dimensions.width5,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image
                        recommendedProducts.isLoading
                            ? Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        // image: AssetImage("assets/images/apple1.jpg")
                                        image: NetworkImage(Constants.baseUrl +
                                            Constants.uploadUrl +
                                            recommendedProducts
                                                .recommendedProductList[index]
                                                .img!))),
                              )
                            : CircularProgressIndicator(),
                        //text
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                children: [
                                  BigText(
                                      text: recommendedProducts
                                          .recommendedProductList[index].name!),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Flexible(
                                      child: SmallText(
                                          text: recommendedProducts
                                              .recommendedProductList[index]
                                              .description!)),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                        icon: Icons.circle_sharp,
                                        iconColor: AppColors.iconColor1,
                                        text: "Normal",
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.location_on,
                                        iconColor: AppColors.mainColor,
                                        text: "1.7km",
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.access_time_rounded,
                                        iconColor: AppColors.iconColor2,
                                        text: "24min",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        })
      ],
    );
  }

  Widget _buildPageItem(int position, Products popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (position == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - position) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currentPageValue - position) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor), 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(children: [
        GestureDetector(
          //index pass
          onTap: () => Get.toNamed(RoutesHelper.getPopularFood(position)),
          child: Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Color(0xFF69c5df),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    // image: AssetImage("images/apple.jpg"))),
                    image: NetworkImage(Constants.baseUrl +
                        Constants.uploadUrl +
                        popularProduct.img!))),
          ),
        ),
        Align(
          child: Container(
            height: Dimensions.pageViewContainer,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
                top: Dimensions.height140),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(
                      color: Colors.white,
                      // blurRadius: 5.0,
                      offset: Offset(5, 0)),
                  BoxShadow(
                      color: Colors.white,
                      // blurRadius: 5.0,
                      offset: Offset(5, 0)),
                ]),
            child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: AppColumn(text: popularProduct.name!)),
          ),
        ),
      ]),
    );
  }
}
