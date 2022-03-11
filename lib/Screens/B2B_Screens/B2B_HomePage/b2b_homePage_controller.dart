import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Notification/notifications_ui.dart';
import 'package:mangalo_app/Model/B2B_Model/B2BProuctModel/b2b_product_model.dart';
import 'package:mangalo_app/Model/Category_Model/category_model.dart';
import 'package:mangalo_app/Services/Notification/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class B2BHomePageController extends GetxController {
  RxList<String> b2bbannerList = <String>[].obs;
  RxList<Category> b2bcategoryList = <Category>[].obs;
  RxList<B2BProduct> productList = <B2BProduct>[].obs;



//!----Messaging
  late FirebaseMessaging firebaseMessaging;
//!-------

  //! ---Drop Down
  final selected = "select".obs;
  void setSelected(String value) {
    selected.value = value;
    print(value);
  }

  Future getB2BBanner() async {
    var response = await B2BHomePageBanner().getB2BHomePgaeBanner();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      jsonData['banners'].forEach((element) {
        b2bbannerList.add(element['image']);
        print(element['image']);
      });
    }
    update();
  }

  Future getB2BCategory() async {
    var response = await B2bCategoryApi().getB2BCategoryfromApi();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      jsonData['Categories'].forEach((element) {
        b2bcategoryList.add(Category(
          id: element['id'],
          name: element['name'],
          pid: element['pid'],
          image: element['image'],
          categoryFirstChildern: List<CategoryFirstChild>.from(
              element['children']
                  .map((x) => CategoryFirstChild.fromJson(x))).toList(),
        ));
      });
    }
  }

  onBoardingDataFalse() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoardingScreen', false);
  }

  getRecommendContainer() async {
    var response = await B2bRecommendedProductApi().getB2BProuctUsingApi();
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData);
      productList.clear();
      jsonData['products'].forEach((element) {
        productList.add(B2BProduct.fromJson(element));
      });
    } else {
      print(jsonData);
    }
  }

  //! Init Screen
  @override
  void onInit() {
    Get.put(NotificationService());
    onBoardingDataFalse();
    getB2BBanner();
    getRecommendContainer();
    getB2BCategory();
    super.onInit();
  }
}
