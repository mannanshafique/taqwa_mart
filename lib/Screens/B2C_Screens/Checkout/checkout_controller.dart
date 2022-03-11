import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/Delivery_Time_Model/delivery_time_model.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Map/Map_Controller/mapController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutController extends GetxController {
  //!---Radio
  RxInt selectedRadio = 0.obs;
  setSelectedRadio(int val) {
    selectedRadio.value = val;
  }

  RxList<DelieveryTime> deliverTimeList = <DelieveryTime>[].obs;
  getDeliveryTimeFromApi() async {
    var responseDeliveryTime = await DeliveryTimes().getdeliveryTimes();
    if (responseDeliveryTime.statusCode == 200) {
      // isLoading.value = false;
      var jsonData = jsonDecode(responseDeliveryTime.body);
      jsonData['data']['DelieveryTimes'].forEach((element) {
        // print(element);
        deliverTimeList.add(DelieveryTime.fromJson(element));
      });
    }
  }

  //!--(end Radio)
  SharedPreferences? sharedPreferences;
  final userNameTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final additionalAddressTextEditingController = TextEditingController();
  //! Method setTextEditingFromSharedPref
  setTextEditingFromSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userNameTextEditingController.text =
        (sharedPreferences!.getString('userName').toString() == 'null')
            ? ''
            : sharedPreferences!.getString('userName').toString();
    phoneTextEditingController.text =
        (sharedPreferences!.getString('userPhone').toString() == 'null')
            ? ''
            : sharedPreferences!.getString('userPhone').toString();
    addressTextEditingController.text =
        sharedPreferences!.getString('updatedAddress').toString();
    print(
        'Address From Shred ${sharedPreferences!.getString('updatedAddress').toString()}');
  }

  @override
  void onInit() {
    getDeliveryTimeFromApi();
    setTextEditingFromSharedPref();
    super.onInit();
  }
}
