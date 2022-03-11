import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';

class ProductDetailController extends GetxController
    with SingleGetTickerProviderMixin {
  List<ProductAttribute> productAttributeList = <ProductAttribute>[];

  ProductDetailController({required this.productAttributeList});

  List<Tab> myTabs = <Tab>[];
  RxInt tabControllerIndex = 0.obs;
  TabController? tabcontroller;

  generateTab() {
    for (int j = 0; j < productAttributeList.length; j++) {
         myTabs.add(Tab(
        text: productAttributeList[j].size.toString()+' '+
        productAttributeList[j].sizeType.toString(),
      ));
      print(productAttributeList[j].size.toString()+' '+
        productAttributeList[j].sizeType.toString(),);
      }
    // for (int i = 0; i < productList.length; i++) {
      
    // }
    tabcontroller = TabController(vsync: this, length: myTabs.length);
  }

  void tabBarListner() {
    tabcontroller!.addListener(() async {
      if (tabcontroller!.indexIsChanging) {
        //! Its Means when user click on tab then firstly that function Run the Else----> Both Run when User click
        //! if user Scrool the only 1 else run

      } else {
        print('Scrool to Update Index');
        tabControllerIndex.value = tabcontroller!.index;
        update();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    generateTab();
    tabBarListner();
  }

  @override
  void onClose() {
    tabcontroller!.dispose();
    super.onClose();
  }
}
