import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Screens/B2C_Screens/AllCategoryView/category_view.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/cart_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/HomePage_Controller/homepage_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/homepage.dart';
import 'package:mangalo_app/Screens/B2C_Screens/SearchScreen/search_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/setting_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key, required this.initailIndex}) : super(key: key);
  int initailIndex;
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final homePageController = Get.put(HomePageController());
  // final homePageController = Get.find<HomePageController>();

  PersistentTabController _controller = PersistentTabController();

  var position;
  var positionCurrent;
  currentLocatiion() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      try {
        updateText(LatLng(position.latitude, position.longitude));
      } catch (e) {}
    } catch (e) {
     LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        try {
          updateText(LatLng(position!.latitude, position!.longitude));
        } catch (e) {
          print(e);
        }
      }
      print(e);
      print('Presmission Denied');
    }
  }

  updateText(LatLng newMarkPosition) async {
    List<Placemark> p = await placemarkFromCoordinates(
        newMarkPosition.latitude, newMarkPosition.longitude);
    Placemark place = p[0];
    setState(() {
      positionCurrent = "${place.name}, ${place.subLocality}, ${place.country}";
    });

    print(positionCurrent);
    print('---------------------------------------------------------');
  }

  @override
  void initState() {
    currentLocatiion();
    _controller = PersistentTabController(initialIndex: widget.initailIndex);

    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(pickUpLocation: positionCurrent ?? 'Loading....'),
      CategoryView(
        categoryList: homePageController.categoryList,
      ),
      CartScreen(),
      SearchScreen(),
      SettingScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_list),
        title: ("Category"),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
        title: ("Cart"),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: greenColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Account"),
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
