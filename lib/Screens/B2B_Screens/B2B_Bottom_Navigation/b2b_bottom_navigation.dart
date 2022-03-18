import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/account_screen.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_AllCategoryView/b2b_allCategoryView.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_screen.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Listing/b2b_lisitng.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_SearchScreen/b2b_search_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/SearchScreen/search_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class B2BBottomNavigation extends StatefulWidget {
  B2BBottomNavigation({Key? key, required this.initailIndex}) : super(key: key);
  final int initailIndex;
  @override
  _B2BBottomNavigationState createState() => _B2BBottomNavigationState();
}

class _B2BBottomNavigationState extends State<B2BBottomNavigation> {
  final homePageController = Get.put(B2BHomePageController());
  // final homePageController = Get.find<HomePageController>();

  PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    // currentLocatiion();
    _controller = PersistentTabController(initialIndex: widget.initailIndex);

    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      B2BHomePage(),
      B2BAllCategoryView(),
      B2BCartScreen(),
      // B2BSearchScreen(),
      B2BListing(),
      AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("home".tr),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_list),
        title: ("categories".tr),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
        title: ("cart".tr),
        // iconSize: 22.0,
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(CupertinoIcons.search),
      //   title: ("search".tr),
      //   activeColorPrimary: greenColor,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.list_bullet),
        title: ("listing".tr),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("account".tr),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    ));
  }
}
