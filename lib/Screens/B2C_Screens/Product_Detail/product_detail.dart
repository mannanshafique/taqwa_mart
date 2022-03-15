import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/Cart_Controller/cart_controller.dart';

import 'Product_detail_controller/product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  List<ProductAttribute> productAttrList = [];
  String name;
  String desc;
  int productId;
  ProductDetailScreen({
    Key? key,
    required this.productAttrList,
    required this.name,
    required this.desc,
    required this.productId,
  }) : super(key: key);
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    //!--------------------
    // print(productAttrList)
    //!--------------------
    final productDetailController =
        Get.put(ProductDetailController(productAttributeList: productAttrList));
    return Scaffold(
      //  backgroundColor: whiteColor.withOpacity(0.98),
      // bottomSheet: CommonWidget().bottomItemSheet(),

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          tabs: productDetailController.myTabs,
          labelColor: blackColor,
          labelPadding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          unselectedLabelColor: lightgreyColor,
          indicatorColor: greenColor,
          controller: productDetailController.tabcontroller,
        ),
      ),
      body: TabBarView(
        controller: productDetailController.tabcontroller,
        children: productDetailController.myTabs.map((Tab tab) {
          return Obx(() => Container(
                child: (productAttrList.isEmpty)
                    ? Center(
                        child: Text('No Data Found'),
                      )
                    : oneLiter(
                        //! _----------Name
                        title: name +
                            ' ' +
                            productAttrList[productDetailController
                                    .tabControllerIndex.value]
                                .size
                                .toString() +
                            ' ' +
                            productAttrList[productDetailController
                                    .tabControllerIndex.value]
                                .sizeType
                                .toString(), //! --End Name
                        des: desc,
                        productNestId: productAttrList[productDetailController
                                .tabControllerIndex.value]
                            .id,
                        imagePath: productAttrList[productDetailController
                                .tabControllerIndex.value]
                            .image,
                        dicountPercent: productAttrList[productDetailController
                                .tabControllerIndex.value]
                            .discountPercentage,
                        orignalPrice: productAttrList[productDetailController
                                .tabControllerIndex.value]
                            .price,
                        stock: productAttrList[productDetailController
                                .tabControllerIndex.value]
                            .stock,
                        discountPrice: productAttrList[productDetailController
                                .tabControllerIndex.value]
                            .discountPrice,
                      ),
              ));
        }).toList(),
      ),
    );
  }

  Widget oneLiter(
      {title,
      des,
      productNestId,
      imagePath,
      dicountPercent,
      orignalPrice,
      stock,
      discountPrice}) {
    return SafeArea(
        child: Container(
      child: Container(
        width: double.infinity,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    // Get.bottomSheet(
                    //   CommonWidget().bottomItemSheet(),enableDrag: true);
                  },
                  child: Stack(
                    children: [
                      Image.network('${b2CimageStartUrl+imagePath}'),

                      // !Discount % Shown On Image
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: (dicountPercent != 0)
                            ? Container(
                                decoration: BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(10),
                                    )),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: CommonWidget().customText(
                                    "$dicountPercent % off",
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: CommonWidget().customText(
                                    "", whiteColor, 14.0, FontWeight.w400, 1)),
                      ),
                      // ! End Discount % Shown On Image
                    ],
                  )),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  CommonWidget().sizedBox(10.0, 0.0),
                  CommonWidget()
                      .customText(title, greyColor, 20.0, FontWeight.w500, 1),
                  CommonWidget().sizedBox(10.0, 0.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonWidget().customText(
                          'Rs.', blackColor, 30.0, FontWeight.w600, 1),
                      //! Price Shown on discount And Without Discount
                      (discountPrice == 0)
                          ? Row(
                              children: [
                                CommonWidget().customText(
                                    orignalPrice.toString(),
                                    blackColor,
                                    40.0,
                                    FontWeight.w900,
                                    1),
                                CommonWidget().sizedBox(00.0, 5.0),
                                CommonWidget().customText(
                                    '', blackColor, 40.0, FontWeight.w900, 1),
                              ],
                            )
                          : Row(
                              children: [
                                CommonWidget().customText(
                                    discountPrice.toString(),
                                    blackColor,
                                    40.0,
                                    FontWeight.w900,
                                    1),
                                CommonWidget().sizedBox(00.0, 5.0),
                                Text(
                                  orignalPrice.toString(),
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                      //! End Price Shown on discount And Without Discount
                    ],
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  CommonWidget().customText(
                      des.toString(), greyColor, 18.0, FontWeight.w300, 5),
                  CommonWidget().sizedBox(20.0, 0.0),
                  Container(
                      height: 35,
                      width: 180,
                      child: addToCartButton(title, discountPrice,
                          productNestId, imagePath, stock)),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

//! Add the Item In cart
  Widget addToCartButton(completeName, price, productId, imagePath, int stock) {
    return Obx(() {
      var itemListDetail;
      var isInCart = false;
      for (int i = 0; i < cartController.itemsList.length; i++) {
        if (productId == cartController.itemsList[i].id) {
          itemListDetail = cartController.itemsList[i];
          if (cartController.itemsList[i].isInCart) {
            isInCart = true;
          }
        } else {}
      }
      return (!isInCart)
          ? CommonWidget().addToCartContainer(0, () {
              print('Added Product Id$productId');
              if (stock == 0) {
                Get.snackbar('Message', 'Product is Out of Stock');
              } else {
                cartController.addProduct(CartModel(
                  completeName,
                  1,
                  price.toString(),
                  stock: stock,
                  isInCart: true,
                  id: productId,
                  imagePath:
                      '${b2CimageStartUrl+imagePath}',
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
}
