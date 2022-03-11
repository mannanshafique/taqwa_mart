import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class B2bProfileController extends GetxController {
  RxString fullName = ''.obs;
  RxString shopName = ''.obs;
  RxString mobileNo = ''.obs;
  RxString address = ''.obs;
  RxBool isLoading = true.obs;

  final phoneTextEditingController = TextEditingController();

  getUserDetail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLoading.value = true;
    var response = await B2BUserProfile().getB2bUserProfileData();
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      fullName.value = jsonData['User']['name'];
      shopName.value = jsonData['User']['shop_name'];
      mobileNo.value = jsonData['User']['phone'];
      address.value = sharedPreferences.getString('b2buserAddress')!;
    } else {
      print(jsonData);
    }
  }

  updateUserProfile({phone}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLoading.value = true;
    var response =
        await B2BUpdateUserProfile().b2bUpdateUserProfileData(phone: phone);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      fullName.value = jsonData['User']['name'];
      shopName.value = jsonData['User']['shop_name'];
      mobileNo.value = jsonData['User']['phone'];
      address.value = sharedPreferences.getString('b2buserAddress')!;
    } else {
      print(jsonData);
    }
  }

  @override
  void onInit() {
    getUserDetail();
    super.onInit();
  }
}
