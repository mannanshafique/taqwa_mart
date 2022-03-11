import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Login_Screen/login_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/BottomNavigation/BottomNavigation.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/setting_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
//!----Messaging
  late FirebaseMessaging firebaseMessaging;
  late SharedPreferences sharedPreferences;

  void onInit() async {
    //!
    super.onInit();
  }

  void loading() {
    isLoading.value = !isLoading.value;
    print('isLoading');
    print(isLoading.value);
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    isLoading.value = false;
    super.onClose();
  }

//! Start
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userName") == null) {
      // Get.off(() => LoginScreen(toggleView: toggleView));
    } else {
      // Get.off(()=>MainScreen());
    }
  }
//! End

//! ----*Register Button Click
  registerButtonOnclick(name, email, password, phone) async {
    loading(); //! ---- Start Loading
    var response = await UserSignUp().userSignUp(name, email, password, phone);
    print('SignUp Api Response ${response.statusCode}');
    //!
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      loading(); //! ---- End Loading
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', jsonData['Token']);
      sharedPreferences.setString('userEmail', jsonData['User']['email']);
      sharedPreferences.setString('userName', jsonData['User']['name']);
      sharedPreferences.setString('userPhone', jsonData['User']['phone']);
      sharedPreferences.setString(
            'userID', jsonData['User']['id'].toString());
      Get.dialog(CustomDialogue(
        title: 'Sucess',
        iconData: Icons.check,
        backColor: greenColor,
        subtitle: 'User Register Sucessfuly',
      )).timeout(Duration(seconds: 4)).whenComplete(() {
        Get.delete<SettingScreenController>();
        Get.off(() => BottomNavigation(
              initailIndex: 2,
            ));
      });
    } else {
      Get.dialog(CustomDialogue(
        title: 'Failed',
        iconData: Icons.close,
        backColor: Colors.red,
        subtitle: 'User Register Failed',
      )).timeout(Duration(seconds: 4)).whenComplete(() {
        // Get.back();
      });
    }
  }

//! ----*Login Button Click
  loginButtonOnclick(
    email,
    password,
  ) async {
    loading(); //! ---- Start Loading
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) async {
      print('its Login Token $value');
      //!------Value is device token
      var response = await UserLogin().userLogin(email, password, value);
      print('Login Api Response ${response.statusCode}');
      //!
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        loading(); //! ---- End Loading
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('accessToken', jsonData['Token']);
        sharedPreferences.setString('userEmail', jsonData['User']['email']);
        sharedPreferences.setString('userName', jsonData['User']['name']);
        sharedPreferences.setString('userPhone', jsonData['User']['phone']);
        sharedPreferences.setString(
            'userID', jsonData['User']['id'].toString());
        Get.delete<SettingScreenController>();
        Get.off(() => BottomNavigation(
              initailIndex: 2,
            ));

        // print(jsonData['Token']);
        // print(jsonData['User']['email']);
        // print(jsonData['User']['name']);
        // print(jsonData['User']['phone']);
      } else {
        Get.dialog(CustomDialogue(
          title: 'Failed',
          iconData: Icons.close,
          backColor: Colors.red,
          subtitle: 'User Login Failed',
        )).timeout(Duration(seconds: 4)).whenComplete(() {
          // Get.back();
        });
      }
    });
  }
}
