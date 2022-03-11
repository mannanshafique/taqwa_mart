import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class B2BCheckOutController extends GetxController {
  SharedPreferences? sharedPreferences;
  final userNameTextEditingController = TextEditingController();
  final storeNameTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();

  setTextEditingFromSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userNameTextEditingController.text =
        sharedPreferences!.getString('b2buserName').toString();
    storeNameTextEditingController.text =
        sharedPreferences!.getString('b2buserStoreName').toString();
    phoneTextEditingController.text =
        sharedPreferences!.getString('b2buserPhone').toString();
    addressTextEditingController.text =
        sharedPreferences!.getString('b2buserAddress').toString();
  }

  @override
  void onInit() {
    setTextEditingFromSharedPref();
    super.onInit();
  }
}
