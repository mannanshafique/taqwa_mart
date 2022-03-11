import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString mobileNo = ''.obs;
  RxString address = ''.obs;
  RxBool isLoading = true.obs;

  final phoneTextEditingController = TextEditingController();

  getUserDetail() async {
    isLoading.value = true;
    var response = await UserProfile().getUserProfileData();
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      fullName.value = jsonData['User']['name'];
      email.value = jsonData['User']['email'];
      mobileNo.value = jsonData['User']['phone'];
    } else {
      print(jsonData);
    }
  }

  fetchAddressFromSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    address.value = sharedPreferences.getString('updatedAddress')!;
  }

  updateUserProfile({phone}) async {
    isLoading.value = true;
    var response =
        await UpdateUserProfile().updateUserProfileData(phone: phone);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      fullName.value = jsonData['User']['name'];
      email.value = jsonData['User']['email'];
      mobileNo.value = jsonData['User']['phone'];
    } else {
      print(jsonData);
    }
  }

  @override
  void onInit() {
    fetchAddressFromSharedPref();
    getUserDetail();
    super.onInit();
  }
}
