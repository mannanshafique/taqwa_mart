import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/Cart_Controller/cart_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Product_Detail/Product_detail_controller/product_detail_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Product_Detail/product_detail.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'Sub_category_controller/sub_category_controller.dart';

class SubCategoryDetailScreen extends StatelessWidget {
  final String pid;
  final int comingTabIndex;
  String titleName;
  SubCategoryDetailScreen(
      {Key? key,
      required this.pid,
      required this.titleName,
      required this.comingTabIndex})
      : super(key: key);

  final cartController = Get.find<CartController>();

  final String descText =
      'Olpers Milk is free of preservatives, UHT treated and goes through a rigorous scrutiny of 28 different types of quality tests before reaching consumers.';
  @override
  Widget build(BuildContext context) {
    final subCategoryController =
        Get.put(SubCategoryController(pid: pid, comingIndex: comingTabIndex));
    return Obx(() => subCategoryController.isLoading.value
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            //! ------------**AppBar Start**---------------
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  print(subCategoryController.isProductLoading.value);
                  if (subCategoryController.isProductLoading.value) {
                  } else {
                    Navigator.pop(context);
                    Get.delete<SubCategoryController>();
                  }
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
              ),

              title: Text(
                titleName,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              elevation: 0.0,
              backgroundColor: lightgreenColor,
              //! Custom Tabbar
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(90.0),
                child: Container(
                  child: Align(
                      //! Its Help To align Tabbar Content (Left Right)
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! Tab Bar
                          TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: subCategoryController.myTabs,
                            labelColor: blackColor,
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                            unselectedLabelColor: lightgreyColor,
                            indicatorColor: greenColor,
                            controller: subCategoryController.tabcontroller,
                          ),
                          //! Nested List
                          CommonWidget().sizedBox(5.0, 0.0),
                          Container(
                              height: 45,
                              child: Obx(() => ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      subCategoryController.childernCat.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() => nestedCategoryList(() {
                                          print(subCategoryController
                                              .childernCat[index].name);
                                          print(subCategoryController
                                              .childernCat[index].id);
                                          subCategoryController
                                              .updateChildCatContainer(
                                                  index,
                                                  subCategoryController
                                                      .childernCat[index].id);
                                          //  subCategoryController.selectChildernCat[index] = !subCategoryController.selectChildernCat[index];
                                          print(subCategoryController
                                              .selectChildernCat);
                                        },
                                            subCategoryController
                                                .selectChildernCat[index],
                                            subCategoryController
                                                .childernCat[index].name));
                                  }))),
                          CommonWidget().sizedBox(5.0, 0.0),
                        ],
                      )),
                ),
              ),
            ),
            //! ------------**AppBar End**---------------
            body: TabBarView(
              controller: subCategoryController.tabcontroller,
              children: subCategoryController.myTabs.map((Tab tab) {
                return Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: (subCategoryController.isProductLoading.value)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : (subCategoryController.productList.isEmpty)
                            ? Center(
                                child: Text('No Data Found'),
                              )
                            : Obx(
                                () => GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.5
                                            //! For Size MAnagment
                                            ),
                                    // SliverGridDelegateWithMaxCrossAxisExtent(
                                    //     maxCrossAxisExtent: 200,
                                    //     crossAxisSpacing: 6,
                                    //     mainAxisSpacing: 8,
                                    //     childAspectRatio:
                                    //         0.7 //! For Size MAnagment
                                    //     ),
                                    shrinkWrap: true,
                                    itemCount: subCategoryController
                                        .productList.length,
                                    itemBuilder: (context, index) {
                                      print('Building Ui-----------------');
                                      var productDetail = subCategoryController
                                          .productList[index]
                                          .productAttributes[0];
                                      print('its its $index');
                                      return productViewContainer(
                                        addtoCartButtonWidget: addToCartButton(
                                            subCategoryController,
                                            index,
                                            productDetail),
                                        discountPercentage:
                                            productDetail.discountPercentage,
                                        discountPrice:
                                            productDetail.discountPrice,
                                        imagePath: productDetail.image,
                                        name: subCategoryController
                                            .productList[index].name,
                                        retailprice:
                                            productDetail.price.toString(),
                                        size:
                                            '${productDetail.size} ${productDetail.sizeType}',
                                        onImageTap: () {
                                          //   //! On tap on Product ==> Move to Product Detail Screen
                                          //   //! Comment due president bottom remain in bottom
                                          //   // Get.to(() => ProductDetailScreen(
                                          //   //       name: subCategoryController
                                          //   //           .productList[index].name,
                                          //   //       desc: subCategoryController
                                          //   //           .productList[index]
                                          //   //           .discription,
                                          //   //       productAttrList:
                                          //   //           subCategoryController
                                          //   //               .productList[index]
                                          //   //               .productAttributes,
                                          //   //       productId: subCategoryController
                                          //   //           .productList[index].id,
                                          //   //     ));
                                          Get.delete<ProductDetailController>();
                                          pushNewScreen(
                                            context,
                                            screen: ProductDetailScreen(
                                              name: subCategoryController
                                                  .productList[index].name,
                                              desc: subCategoryController
                                                  .productList[index]
                                                  .discription,
                                              productAttrList:
                                                  subCategoryController
                                                      .productList[index]
                                                      .productAttributes,
                                              productId: subCategoryController
                                                  .productList[index].id,
                                            ),
                                            withNavBar: true,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        },
                                      );
                                    }),
                              ));
              }).toList(),
            ),
          ));
  }

  Widget addToCartButton(SubCategoryController subCategoryController, index,
      ProductAttribute productDetail) {
    return Obx(() {
      var itemListDetail;
      var isInCart = false;
      for (int i = 0; i < cartController.itemsList.length; i++) {
        if (subCategoryController.productList[index].name ==
            cartController.itemsList[i].name) {
          itemListDetail = cartController.itemsList[i];
          if (cartController.itemsList[i].isInCart) {
            isInCart = true;
          }
        } else {}
      }
      return (!isInCart)
          ? CommonWidget().addToCartContainer(0, () {
              print(
                  'its Id for Cart added${subCategoryController.productList[index].productAttributes[0].id}');
              print(
                  'stock${subCategoryController.productList[index].productAttributes[0].stock}');
              if (subCategoryController
                      .productList[index].productAttributes[0].stock ==
                  0) {
                Get.snackbar('Message', 'Product is Out of Stock');
              } else {
                cartController.addProduct(CartModel(
                  subCategoryController.productList[index].name,
                  1,
                  (productDetail.discountPrice.toString() == '0')
                      ? productDetail.price.toString()
                      : productDetail.discountPrice.toString(),
                  isInCart: true,
                  stock: subCategoryController
                      .productList[index].productAttributes[0].stock,
                  id: subCategoryController
                      .productList[index].productAttributes[0].id,
                  imagePath:
                      'http://165.227.69.207/zkadmin/public/uploads/${subCategoryController.productList[index].productAttributes[0].image}',
                ));
              }
            }, () {}, () {}, () {}) //!
          : CommonWidget()
              .addToCartContainer(itemListDetail.quantity ?? 1, () {}, () {
              if (itemListDetail.stock == itemListDetail.quantity) {
              } else {
                cartController.updateProduct(
                    itemListDetail, itemListDetail.quantity! + 1);
              }
            }, () {
              cartController.updateProduct(
                  itemListDetail, itemListDetail.quantity! - 1);
            }, () {
              cartController.removeProduct(itemListDetail);
            });
    });
  }

  Widget addToCartContainerInner(count, onTap, incTap, decTap, deleteTap) {
    //! if (count ==0 )  Add to cart Text Container
    return (count == 0)
        ? CommonWidget().button(greenColor, whiteColor, 'Add to cart', onTap,
            EdgeInsets.symmetric(vertical: 0), 18.0, FontWeight.normal)
        :
        //!  Add to cart Incr/Dec Button Container
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: new Border.all(
                  color: greenColor, width: 2.2, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: (count == 1)
                      ? GestureDetector(
                          //! Delete Tap
                          onTap: deleteTap,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Image.asset('assets/Images/delete.png'),
                          ),
                        )
                      : GestureDetector(
                          //! Decrement Tap
                          onTap: decTap,
                          child: Icon(
                            Icons.remove,
                            color: greenColor,
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: CommonWidget().customText(
                      count.toString(), blackColor, 16.0, FontWeight.w500, 2),
                ),
                GestureDetector(
                  //! Increment Tap
                  onTap: incTap,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.add,
                      color: greenColor,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget nestedCategoryList(onPressed, clickValue, text) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            border: (clickValue)
                ? Border.all(color: Colors.green, width: 2.0)
                : Border(),
            color: Colors.grey.withOpacity(0.28),
            borderRadius: BorderRadius.circular(5)),
        child: CommonWidget()
            .customText(text, Colors.black, 15.0, FontWeight.w400, 1),
      ),
    );
  }

  Widget productViewContainer(
      {String? imagePath,
      String? name,
      String? retailprice,
      int? discountPrice,
      int? discountPercentage,
      required Widget addtoCartButtonWidget,
      required onImageTap,
      // required onSizeTap
      required size}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: lightgreyColor.withOpacity(0.1)),
      //width: 160,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(1.5),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: whiteColor),
          child: Column(
            children: [
              //! -------(Off Container Start)
              Row(
                children: [
                  (discountPercentage != 0)
                      ? Container(
                          decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomRight: Radius.circular(10),
                              )),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: CommonWidget().customText(
                              "$discountPercentage % off",
                              whiteColor,
                              14.0,
                              FontWeight.w400,
                              1))
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomRight: Radius.circular(10),
                              )),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: CommonWidget().customText(
                              "", whiteColor, 14.0, FontWeight.w400, 1)),
                ],
              ),
              //! -------(Off Container End)
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: (imagePath == null)
                    ? Image.asset('assets/Images/logo_green.png')
                    : GestureDetector(
                        onTap: onImageTap,
                        child: Image.network(
                          'http://165.227.69.207/zkadmin/public/uploads/$imagePath',
                          fit: BoxFit.cover,
                        ),
                      ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! ----------(discount Data Start)
                    (discountPrice == 0)
                        ? Column(
                            children: [
                              CommonWidget().customText('Rs. $retailprice',
                                  blackColor, 20.0, FontWeight.w900, 1),
                              Text(
                                '',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget().customText('Rs. $discountPrice',
                                  blackColor, 20.0, FontWeight.w900, 1),
                              Text(
                                'Rs. $retailprice',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                    //! ------------***Discound End**--------------
                    CommonWidget().sizedBox(5.0, 0.0),
                    //! ------------***Title**--------------
                    Expanded(
                      child: CommonWidget().customText(
                          name!, blackColor, 16.0, FontWeight.normal, 3),
                    ),
                    CommonWidget().sizedBox(5.0, 0.0),
                    //!--------------------Bottom Sheet
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5)),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(size.toString()),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                    CommonWidget().sizedBox(5.0, 0.0),
                    //! Add to cart Button
                    addtoCartButtonWidget,
                    CommonWidget().sizedBox(8.0, 0.0),
                  ],
                ),
              )),
            ],
          )),
    );
  }

  // Widget productViewContainer(onTap, String imagePath, String name, price,
  //     Widget addtoCartButtonWidget) {
  //   return Container(
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //     // width: 200,
  //     margin: EdgeInsets.symmetric(horizontal: 2),
  //     child: Card(
  //         elevation: 2.0,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         child: Column(
  //           children: [
  //             Expanded(
  //                 child: GestureDetector(
  //               onTap: onTap,
  //               child: Container(
  //                 child: Image.network(
  //                   'http://165.227.69.207/zkadmin/public/uploads/$imagePath',
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             )),
  //             Expanded(
  //                 child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CommonWidget().customText('Rs ${price.toString()}',
  //                       blackColor, 20.0, FontWeight.w900, 1),
  //                   CommonWidget().sizedBox(5.0, 0.0),
  //                   SizedBox(
  //                     height: 40,
  //                     child: CommonWidget().customText(
  //                         name,
  //                         blackColor.withOpacity(0.7),
  //                         16.0,
  //                         FontWeight.w400,
  //                         2),
  //                   ),
  //                   CommonWidget().sizedBox(2.0, 0.0),
  //                   //! Add to cart Button
  //                   addtoCartButtonWidget,

  //                   CommonWidget().sizedBox(5.0, 0.0),
  //                 ],
  //               ),
  //             )),
  //           ],
  //         )),
  //   );
  // }
}
