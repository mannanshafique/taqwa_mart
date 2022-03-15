import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Notification/notifications_ui.dart';
import 'package:mangalo_app/Model/Category_Model/category_model.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  RxList<String> bannerList = <String>[].obs;
  RxList<Category> categoryList = <Category>[].obs;
  RxList<Product> productList = <Product>[].obs;

//!----Messaging
  late FirebaseMessaging firebaseMessaging;
//!-------

  //! ---Drop Down
  final selected = "select".obs;
  void setSelected(String value) {
    selected.value = value;
    print(value);
  }

  Future getBanner() async {
    var response = await HomePageBanner().getHomePgaeBanner();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      jsonData['banners'].forEach((element) {
        bannerList.add(element['image']);
        print(element['image']);
      });
    }
    update();
  }

  Future getCategory() async {
    var response = await CategoryApi().getCategoryfromApi();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      jsonData['Categories'].forEach((element) {
        categoryList.add(Category(
            id: element['id'],
            name: element['name'],
            pid: element['pid'],
            image: element['image'],
            categoryFirstChildern: List<CategoryFirstChild>.from(
              element['children'].map((x) => CategoryFirstChild.fromJson(x))),
            ));
      });
    }
  }

  onBoardingDataFalse() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoardingScreen', false);
  }

  getRecommendContainer() async {
    var response = await ProuctUsingCategoryApi()
        .getProuctUsingCategoryApi(51);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData);
      productList.clear();
      jsonData['products'].forEach((element) {
        productList.add(Product.fromJson(element));
      });
    } else {
      print(jsonData);
    }
  }

  //! Init Screen
  @override
  void onInit() {
    //!-----
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) async {
      print('its Token $value');
      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        print("message recieved");
        print(event.notification!.body);
        createNotificationsPopUp(
            title: event.notification!.title,
            description: event.notification!.body);
      });
    });
    //!_----
    onBoardingDataFalse();
    getBanner();
    getRecommendContainer();
    getCategory();
    super.onInit();
  }
}
