import 'dart:convert';

import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/Category_Model/category_model.dart';

class B2BAllCategoryController extends GetxController {
  RxList<Category> categoryList = <Category>[].obs;

  Future getB2BCategory() async {
    var response = await B2bCategoryApi().getB2BCategoryfromApi();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      jsonData['Categories'].forEach((element) {
        categoryList.add(Category(
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

  @override
  void onInit() {
    getB2BCategory();
    super.onInit();
  }
}
