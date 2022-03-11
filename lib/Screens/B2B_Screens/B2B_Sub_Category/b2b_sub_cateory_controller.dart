import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/B2B_Model/B2BProuctModel/b2b_product_model.dart';
import 'package:mangalo_app/Model/Nested_Category_Model/nested_category_model.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';

class B2BSubCategoryController extends GetxController
    with SingleGetTickerProviderMixin {
  final String pid;
  final String id;
  final int comingIndex;
  B2BSubCategoryController(
      {required this.pid, required this.comingIndex, required this.id});

//!

//!---------For B2b
  RxList<ChildrenRecursive> categoryChildern = <ChildrenRecursive>[].obs;

//!-----------End For B2b
// RxList<ChildrenRecursive> nestedchildernCat = <ChildrenRecursive>[].obs;
  RxList<ChildrenRecursive> childernWholeData = <ChildrenRecursive>[].obs;
  //! After Tab button Category
  RxList<ChildrenRecursive> childernCat = <ChildrenRecursive>[].obs;
  //! List Of Product
  RxList<B2BProduct> productList = <B2BProduct>[].obs;
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
    tabcontroller!.index =
        comingIndex; //! ----------> Gave the index Coming From Back
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
        // sortSubList(tabcontroller!.index);
        getProdouctUsingApi(categoryChildern[tabcontroller!.index].id);
        print(tabcontroller!.index);
      }
    });
  }

  Future getTabCategory(int index, isTab) async {
    var response = await B2bCategoryApi().getB2BCategoryfromApi();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      //! For Tabs
      if (isTab) {
        jsonData['Categories'].forEach((element) {
          // print(element['id']);
          // print('coming $pid');

          // TAbs
          if (pid == '0') {
            if (element['id'].toString() == id) {
              print('inside for loop of categ');
              for (int i = 0; i < element['children'].length; i++) {
                myTabs.add(Tab(
                  text: element['children'][i]['name'],
                ));

                categoryChildern.add(ChildrenRecursive(
                  name: element['children'][i]['name'],
                  id: element['children'][i]['id'],
                  image: element['children'][i]['image'],
                  pid: element['children'][i]['pid'],
                ));
                getProdouctUsingApi(element['children'][index]['id']
                    .toString()); //!----Initially 0 index Chalye

              }
            }
          } else {
            print('Else');
            for (int i = 0; i < element['children'].length; i++) {
              print('${element['children'][i]['name']}----------------------');
              print('${element['children'][i]['id']}----id------------------');
              print('$pid----------------------');
              if (element['children'][i]['pid'].toString() == pid) {
                myTabs.add(Tab(
                  text: element['children'][i]['name'],
                ));
                 categoryChildern.add(ChildrenRecursive(
                  name: element['children'][i]['name'],
                  id: element['children'][i]['id'],
                  image: element['children'][i]['image'],
                  pid: element['children'][i]['pid'],
                ));
                print('Inside Else Child loop----------------------');
                if (element['children'][i]['id'].toString() == id) {
                  
                  getProdouctUsingApi(element['children'][i]['id']
                      .toString()); //!----Initially i means index Chalye
                }
              }
            }
          }
        });
      }
      //  sortSubList(index);

      isLoading.value = false;
    }
  }

// //! For COntainer Bottom of Tabbar
  // sortSubList(index) {
  //   childernCat.clear();
  //   selectChildernCat.clear();
  //   for (int i = 0;
  //       i < categoryChildern.length;
  //       i++) {

  //     var nestedData = categoryChildern[index].childrenRecursive![i];
  //     childernCat.add(ChildrenRecursive(
  //         name: nestedData['name'],
  //         id: nestedData['id'],
  //         image: nestedData['image'],
  //         pid: nestedData['pid'],
  //         childrenRecursive: nestedData['children_recursive']));
  //   }
  //   //! Add false By default
  //   List.generate(childernCat.length, (index) {
  //     selectChildernCat.add(false);
  //   });
  //   //! Fetch Category Id And Send in Product APi  Ex: Eye id
  //   getProdouctUsingApi(childernWholeData[index].id.toString());
  // }

  getProdouctUsingApi(catId) async {
    print('=========Cat Id GOne $catId');
    var response =
        await B2bProuctUsingCategoryApi().getB2BProuctUsingCategoryApi(catId);
    addtoCartCheck
        .clear(); //!-------------------------------------------------------(1)
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData['products']);
      // ProductAttribute
      productList.clear();

      //!----------------------2/12/2021
      jsonData['products'].forEach((element) {
        productList.add(B2BProduct.fromJson(element));
      });
      //! Add false By default to Add to cart
      List.generate(productList.length, (index) {
        addtoCartCheck.add(false);
        print('Added false---------------------------');
      });
      isProductLoading.value = false;
    }
  }

  getSortedProdouctUsingApi(catId) async {
    print('=========Cat Sorted Id GOne $catId');
    var response = await ProuctSortingUsingCategoryApi()
        .getSortedProuctUsingCategoryApi(catId);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      // ProductAttribute
      productList.clear();
      jsonData['products'].forEach((element) {
        productList.add(B2BProduct.fromJson(element));
      });
      isProductLoading.value = false;
      //  print(productList[0].name);

    }
  }
}
