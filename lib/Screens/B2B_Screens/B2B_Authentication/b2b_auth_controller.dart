import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Approval_Waiting/b2b_approval_waiting.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/B2B_Login/b2b_login_screen.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Bottom_Navigation/b2b_bottom_navigation.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class B2BAuthController extends GetxController {
  var comingContext;
  B2BAuthController({this.comingContext});
  RxBool isLoading = false.obs;
  late SharedPreferences sharedPreferences;
  //!----Messaging
  late FirebaseMessaging firebaseMessaging;

  void loading() {
    isLoading.value = !isLoading.value;
    print('isLoading');
    print(isLoading.value);
  }

  void onInit() async {
    //!
    checkLoginStatus(comingContext);
    super.onInit();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    isLoading.value = false;
    super.onClose();
  }

//! Start
  checkLoginStatus(context) async {
    print('B2B Check Status');
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("b2buserAddress") == null) {
      // Get.off(() => LoginScreen(toggleView: toggleView));
    } else {
      if (sharedPreferences.getString("b2buserStatus") == '0') {
        Get.off(() => WaitingApproval(isWaitingApproval: true));
      } else {
        pushNewScreen(
          context,
          screen: B2BBottomNavigation(
            initailIndex: 0,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      }
    }
  }
//! End

//! ----*Register Button Click
  registerButtonOnclick(
      {name,
      password,
      phone,
      shopName,
      additionalAddress,
      required double lat,
      required double lon,
      referral}) async {
    loading(); //! ---- Start Loading
    var response = await B2BUserSignUp().b2buserSignUp(
        name: name,
        password: password,
        phone: phone,
        shopName: shopName,
        lati: lat,
        long: lon,
        address: await fetchAddress(LatLng(lat, lon)) + ' ' + additionalAddress,
        referral: referral);

    print('SignUp Api Response ${response.statusCode}');
    //!
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      loading(); //! ---- End Loading
      Get.dialog(CustomDialogue(
        title: 'Sucess',
        iconData: Icons.check,
        backColor: greenColor,
        subtitle: 'User Register Sucessfuly',
      ))
          .timeout(Duration(seconds: 4))
          .whenComplete(() => Get.offAll(() => B2BLoginScreen()));
    } else if (response.statusCode == 422) {
      loading(); //! ---- End Loading
      var jsonData = jsonDecode(response.body);
      Get.snackbar('Message', jsonData['errors']['phone'][0].toString(),
          backgroundColor: lightgreyColor, colorText: blackColor);
    }
  }

//! ----*Login Button Click
  loginButtonOnclick(phone, password, context) async {
    loading(); //! ---- Start Loading
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) async {
      print('its Login Token $value');
      var response = await B2BUserLogin().b2buserLogin(phone, password, value);
      print('Login Api Response ${response.statusCode}');
      //!
      if (response.statusCode == 200) {
        loading(); //! ---- End Loading
        var jsonData = jsonDecode(response.body);
        sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString(
            'b2buserStoreName', jsonData['Data']['shop_name']);
        sharedPreferences.setString(
            'b2buserName', jsonData['Data']['name'].toString());
        sharedPreferences.setString(
            'b2buserId', jsonData['Data']['id'].toString());
        sharedPreferences.setString(
            'b2buserPhone', jsonData['Data']['phone'].toString());
        sharedPreferences.setString(
            'b2buserlatitude', jsonData['Data']['lat'].toString());
        sharedPreferences.setString(
            'b2buserlongitude', jsonData['Data']['lon'].toString());
        sharedPreferences.setString(
            'b2buserAddress', jsonData['Data']['address'].toString());
        sharedPreferences.setString(
            'b2buserStatus', jsonData['Data']['approved'].toString());

        if (jsonData['Data']['approved'] == '0') {
          Get.off(() => WaitingApproval(
                isWaitingApproval: true,
              ));
        } else {
          pushNewScreen(
            context,
            screen: B2BBottomNavigation(
              initailIndex: 0,
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      } else if (response.statusCode == 401) {
        loading(); //! ---- End Loading
        var jsonData = jsonDecode(response.body);
        Get.snackbar('Message', jsonData['Result'].toString(),
            backgroundColor: lightgreyColor, colorText: blackColor);
      }
    });
  }

  fetchAddress(LatLng newMarkPosition) async {
    List<Placemark> p = await placemarkFromCoordinates(
        newMarkPosition.latitude, newMarkPosition.longitude);

    Placemark place = p[0];
    String positionCurrent =
        "${place.name}, ${place.subLocality}, ${place.country}";

    return positionCurrent;
  }
}
