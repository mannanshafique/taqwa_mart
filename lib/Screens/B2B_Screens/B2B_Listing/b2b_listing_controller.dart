import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/ListingModel/listing_model.dart';

class ListingController extends GetxController {
  RxList<ListRbd> rbdListing = <ListRbd>[].obs;
  final TextEditingController maundTextEditingController =
      TextEditingController();
  RxBool isLoading = true.obs;

  RxString currentrbdItem = 'RBD'.obs;

  final List<String> rbdItems = [
    'RBD',
    'OLIEN',
    'VACCUME',
  ];

  postRbd({required String type, required String maundRate}) async {
    print('hit ');
    var response =
        await B2bRbdList().postB2bRbdList(maundRate: maundRate, type: type);
    isLoading.value = true;
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      rbdListing.clear();
      isLoading.value = false;
      jsonData['Result'].forEach((element) {
        rbdListing.add(ListRbd(brand: element['brand'], rate: element['rate']));
      });
    }
  }

  @override
  void onInit() {
    postRbd(type: 'rbd', maundRate: '14700');
    super.onInit();
  }
}
