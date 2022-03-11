import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/Nested_Category_Model/nested_category_model.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';

class SubCategoryController extends GetxController
    with SingleGetTickerProviderMixin {
  final String pid;
  final int comingIndex;
  SubCategoryController({required this.pid,required this.comingIndex});

//!

//!

// RxList<ChildrenRecursive> nestedchildernCat = <ChildrenRecursive>[].obs;
  RxList<ChildrenRecursive> childernWholeData = <ChildrenRecursive>[].obs;
  //! After Tab button Category
  RxList<ChildrenRecursive> childernCat = <ChildrenRecursive>[].obs;
  //! List Of Product
  RxList<Product> productList = <Product>[].obs; 
  // RxList<ProductAttribute> productList = <ProductAttribute>[].obs; 

  //! child Cat button selector
  RxList<bool> selectChildernCat = <bool>[].obs;
  //! Add to cart button List(check if add to cart or inc or dec)
  RxList<bool> addtoCartCheck = <bool>[].obs;

  final RxList<Tab> myTabs = <Tab>[].obs;
  RxBool isLoading = true.obs;
  RxBool isProductLoading =
      true.obs; //! When user move new tabview show loader until product load
  //  = <Tab>[
  //   Tab(text: '1 Ltr'),
  //   Tab(text: '1.5 Ltr'),
  // ];

  TabController? tabcontroller;

  @override
  void onInit() async {
    super.onInit();
    print('comingIndex $comingIndex');
    await getTabCategory(comingIndex, true);
    tabcontroller = TabController(vsync: this, length: myTabs.length);
    tabcontroller!.index = comingIndex;  //! ----------> Gave the index Coming From Back Screen
    tabBarListner();
  }

  @override
  void onClose() {
    tabcontroller!.dispose();
    super.onClose();
  }

  void tabBarListner() {
    tabcontroller!.addListener(() async {
      if (tabcontroller!.indexIsChanging) {
        //! Its Means when user click on tab then firstly that function Run the Else----> Both Run when User click
        //! if user Scrool the only 1 else run

        print('Tab index ${tabcontroller!.index}');
        print("When Click to chnage Change Index");
      } else {
        print('Scrool to Update Index');
        isProductLoading.value = true;
        sortSubList(tabcontroller!.index);
        print(tabcontroller!.index);
      }
    });
  }

  updateChildCatContainer(index,id) {
    // selectChildernCat[index] = !selectChildernCat[index];
    for (var i = 0; i < selectChildernCat.length; i++) {
      if (i == index) {
        selectChildernCat[i] = true;
         isProductLoading.value = true;
        getSortedProdouctUsingApi(id.toString());
        print('its cat_prod_id $id');
      } else {
        selectChildernCat[i] = false;
      }
    }
    update();
  }

  Future getTabCategory(int index, isTab) async {
    var response = await SubCategoryApi().getsubCategoryfromApi(pid);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      //! For Tabs
      if (isTab) {
        jsonData['Categories']['children_recursive'].forEach((element) {
          // TAbs
          myTabs.add(Tab(
            text: element['name'],
          ));
          childernWholeData.add(ChildrenRecursive(
              name: element['name'],
              id: element['id'],
              image: element['image'],
              pid: element['pid'],
              childrenRecursive: element['children_recursive']));
        });
      }
      sortSubList(index);

      isLoading.value = false;
    }
  }

//! For COntainer Bottom of Tabbar
  sortSubList(index) {
    childernCat.clear();
    selectChildernCat.clear();
    for (int i = 0;
        i < childernWholeData[index].childrenRecursive!.length;
        i++) {
      print(childernWholeData[index].childrenRecursive![i]['name']);
      var nestedData = childernWholeData[index].childrenRecursive![i];
      childernCat.add(ChildrenRecursive(
          name: nestedData['name'],
          id: nestedData['id'],
          image: nestedData['image'],
          pid: nestedData['pid'],
          childrenRecursive: nestedData['children_recursive']));
    }
    //! Add false By default
    List.generate(childernCat.length, (index) {

      selectChildernCat.add(false);
    });
    //! Fetch Category Id And Send in Product APi  Ex: Eye id
    getProdouctUsingApi(childernWholeData[index].id.toString());
  }

  getProdouctUsingApi(catId) async {
    print('=========Cat Id GOne $catId');
    var response =
        await ProuctUsingCategoryApi().getProuctUsingCategoryApi(catId);
    addtoCartCheck.clear(); //!-------------------------------------------------------(1)
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      // print(jsonData);
      // ProductAttribute
      productList.clear();

      jsonData['products'].forEach((element) {
        productList.add(Product.fromJson(element));
      });
       //! Add false By default to Add to cart
    List.generate(productList.length, (index) {
      addtoCartCheck.add(false);
      print('Added false---------------------------');
    });
      isProductLoading.value = false;
      //  print(productList[0].name);

    }
  }
  getSortedProdouctUsingApi(catId) async {
    print('=========Cat Sorted Id GOne $catId');
    var response =
        await ProuctSortingUsingCategoryApi().getSortedProuctUsingCategoryApi(catId);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      // ProductAttribute
      productList.clear();
      jsonData['products'].forEach((element) {
        productList.add(Product.fromJson(element));
      });
      isProductLoading.value = false;
      //  print(productList[0].name);

    }
  }
}
