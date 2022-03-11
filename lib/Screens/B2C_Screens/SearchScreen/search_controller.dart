import 'dart:convert';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';

class SearchController extends GetxController{

List<Product> searchProductList = <Product>[];

RxBool isSearchLoading = false.obs;

 @override
  void onInit() async {
    super.onInit();
    getSearchProdouctUsingApi('');
  }

  getSearchProdouctUsingApi(searchItemName) async {
    isSearchLoading.value = true;
    var response = await Search().getSearchItem(searchItemName);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
    
      searchProductList.clear();
      jsonData['product'].forEach((element) {
        searchProductList.add(Product.fromJson(element));
      });
      isSearchLoading.value = false;
  
    }
  }
}