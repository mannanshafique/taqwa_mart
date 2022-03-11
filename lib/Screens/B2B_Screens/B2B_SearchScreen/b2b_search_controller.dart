import 'dart:convert';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/B2B_Model/B2BProuctModel/b2b_product_model.dart';

class B2BSearchController extends GetxController{

List<B2BProduct> searchProductList = <B2BProduct>[];

RxBool isSearchLoading = false.obs;




  getSearchProdouctUsingApi(searchItemName) async {
    isSearchLoading.value = true;
    var response = await B2BSearch().getB2BSearchItem(searchItemName);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
    
      searchProductList.clear();
      jsonData['products'].forEach((element) {
        searchProductList.add(B2BProduct.fromJson(element));
      });
      isSearchLoading.value = false;
  
    }
  }
}