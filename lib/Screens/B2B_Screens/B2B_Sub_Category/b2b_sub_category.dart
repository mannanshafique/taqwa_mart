import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/B2B_Model/B2BProuctModel/b2b_product_model.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_screen.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Sub_Category/b2b_sub_cateory_controller.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class B2BSubCategoryDetailScreen extends StatelessWidget {
  final String pid;
  final String id;
  final int comingTabIndex;
  String titleName;
  B2BSubCategoryDetailScreen({
    Key? key,
    required this.pid,
    required this.titleName,
    required this.comingTabIndex,
    required this.id,
  }) : super(key: key);

  final b2bCartController = Get.find<B2BCartController>();

  @override
  Widget build(BuildContext context) {
    final subCategoryController = Get.put(B2BSubCategoryController(
        pid: pid, id: id, comingIndex: comingTabIndex));
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
                    Get.delete<B2BSubCategoryController>();
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
                preferredSize: const Size.fromHeight(30.0),
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
                                            childAspectRatio: 0.47
                                            //! For Size MAnagment
                                            ),
                                    shrinkWrap: true,
                                    itemCount: subCategoryController
                                        .productList.length,
                                    itemBuilder: (context, index) {
                                      // print('Building Ui-----------------');
                                      var productDetail = subCategoryController
                                          .productList[index];
                                      // print('its its $index');
                                      return productViewContainer(
                                        addtoCartButtonWidget:
                                            //!------------Add TO cart Button
                                            addToCartButton(
                                                subCategoryController,
                                                index,
                                                productDetail),
                                        discountPercentage:
                                            productDetail.discountPercent,
                                        discountPrice:
                                            productDetail.priceDiscount,
                                        imagePath: productDetail.image,
                                        name: productDetail.name,
                                        retailprice: productDetail.priceRetail
                                            .toString(),
                                        size:
                                            '${productDetail.unit} ${productDetail.unitType}',
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

                                          // pushNewScreen(
                                          //   context,
                                          //   screen: ProductDetailScreen(
                                          //     name: subCategoryController
                                          //         .productList[index].name,
                                          //     desc: subCategoryController
                                          //         .productList[index].discription,
                                          //     productAttrList:
                                          //         subCategoryController
                                          //             .productList,
                                          //     productId: subCategoryController
                                          //         .productList[index].id,
                                          //   ),
                                          //   withNavBar: true,
                                          //   pageTransitionAnimation:
                                          //       PageTransitionAnimation.cupertino,
                                          // );
                                        },
                                      );
                                    }),
                              ));
              }).toList(),
            ),
          ));
  }

  Widget addToCartButton(B2BSubCategoryController subCategoryController, index,
      B2BProduct productDetail) {
    return Obx(() {
      var itemListDetail;
      var isInCart = false;
      for (int i = 0; i < b2bCartController.itemsList.length; i++) {
        //!------29/11/2021
        if (subCategoryController.productList[index].id ==
            b2bCartController.itemsList[i].id) {
          itemListDetail = b2bCartController.itemsList[i];
          if (b2bCartController.itemsList[i].isInCart) {
            isInCart = true;
          }
        } else {}
      }
      return (!isInCart)
          ? CommonWidget().addToCartContainer(0, () {
              //!------29/11/2021
              print(
                  'its Id for Cart added${subCategoryController.productList[index].id}');
              print(
                  'its name for Cart added${subCategoryController.productList[index].name}');
              print(
                  'its price for Cart added${subCategoryController.productList[index].priceDiscount}');
              print(
                  'its Stock ${subCategoryController.productList[index].stock}');

              if (subCategoryController.productList[index].stock == 0) {
                Get.snackbar('Message', 'Product is Out of Stock');
              } else {
                b2bCartController.addProduct(B2BCartModel(
                  stock: subCategoryController.productList[index].stock,
                  name: subCategoryController.productList[index].name,
                  quantity: 1,
                  price: (productDetail.priceDiscount.toString().isEmpty)
                      ? productDetail.priceRetail.toString()
                      : productDetail.priceDiscount.toString(),
                  isInCart: true,
                  id: subCategoryController.productList[index].id,
                  imagePath:
                      '${subCategoryController.productList[index].image}',
                ));
              }
            }, () {}, () {}, () {}) //!
          : CommonWidget()
              .addToCartContainer(itemListDetail.quantity ?? 1, () {}, () {
              if (itemListDetail.stock == itemListDetail.quantity) {
              } else {
                b2bCartController.updateProduct(
                    //!------Increm Tap
                    itemListDetail,
                    itemListDetail.quantity! + 1);
              }
            }, () {
              b2bCartController.updateProduct(
                  //!------decre Tap
                  itemListDetail,
                  itemListDetail.quantity! - 1);
            }, () {
              b2bCartController
                  .removeProduct(itemListDetail); //!------29/11/2021
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
                child: GestureDetector(
                  onTap: onImageTap,
                  child: Image.network(
                    '$imagePath',
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
}
