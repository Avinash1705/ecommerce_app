import 'package:ecommerce_app/ui/account/account_page.dart';
import 'package:ecommerce_app/ui/cart/cart_history.dart';
import 'package:ecommerce_app/ui/cart/cart_page.dart';
import 'package:ecommerce_app/ui/home/main_food_page.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/cupertino.dart ';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../account/map_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;

  List<Widget> pages = [
    MainFoodPage(),
    Container(
      child: CartHistory(),
    ),
    Container(
      child: CartPage(),
    ),
    Container(
      child:AccountPage(),
    ),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox),
        title: ("History"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
    ];
  }
  @override
 /* Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive), label: "history"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "me"),
        ],
      ),
    );
  }*/

  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: pages,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

}
