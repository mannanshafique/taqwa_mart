import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/B2B_Model/B2BProuctModel/b2b_product_model.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_SearchScreen/b2b_search_controller.dart';

class B2BSearchScreen extends StatelessWidget {
  B2BSearchScreen({Key? key}) : super(key: key);

  final b2bsearchController = Get.put(B2BSearchController());
  final b2bCartController = Get.find<B2BCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: textField(context),
      ),
      body: Obx(() => b2bsearchController.isSearchLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : b2bsearchController.searchProductList.length == 0
              ? Center(
                  child: CommonWidget().customText(
                      'No Product Found', blackColor, 25.0, FontWeight.w400, 1),
                )
              : GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 0.5
                      //! For Size MAnagment
                      ),
                  shrinkWrap: true,
                  itemCount: b2bsearchController.searchProductList.length,
                  itemBuilder: (context, index) {
                    // print('Building Ui-----------------');
                    var productDetail =
                        b2bsearchController.searchProductList[index];
                    // print('its its $index');
                    return productViewContainer(
                      addtoCartButtonWidget:
                          //!------------Add TO cart Button
                          addToCartButton(
                              b2bsearchController, index, productDetail),
                      discountPercentage: productDetail.discountPercent,
                      discountPrice: productDetail.priceDiscount,
                      imagePath: productDetail.image,
                      name: productDetail.name,
                      retailprice: productDetail.priceRetail.toString(),
                      size: '${productDetail.unit} ${productDetail.unitType}',
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
                  })),
    );
  }

  Widget addToCartButton(
      B2BSearchController searchController, index, B2BProduct productDetail) {
    return Obx(() {
      var itemListDetail;
      var isInCart = false;
      for (int i = 0; i < b2bCartController.itemsList.length; i++) {
        //!------29/11/2021
        if (searchController.searchProductList[index].id ==
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
                  'its Id for Cart added${searchController.searchProductList[index].id}');
              print(
                  'its name for Cart added${searchController.searchProductList[index].name}');
              print(
                  'its price for Cart added${searchController.searchProductList[index].priceDiscount}');

              if (searchController.searchProductList[index].stock == 0) {
                Get.snackbar('Message', 'Product is Out of Stock');
              } else {
                b2bCartController.addProduct(B2BCartModel(
                  stock: searchController.searchProductList[index].stock,
                  name: searchController.searchProductList[index].name,
                  quantity: 1,
                  price: (productDetail.priceDiscount.toString().isEmpty)
                      ? productDetail.priceRetail.toString()
                      : productDetail.priceDiscount.toString(),
                  isInCart: true,
                  id: searchController.searchProductList[index].id,
                  imagePath:
                      '${searchController.searchProductList[index].image}',
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
                  //!------29/11/2021
                  itemListDetail,
                  itemListDetail.quantity! - 1);
            }, () {
              b2bCartController
                  .removeProduct(itemListDetail); //!------29/11/2021
            });
    });
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
                          name!, blackColor, 16.0, FontWeight.normal, 2),
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

  Widget textField(context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10.0,
        color: Colors.transparent,
        child: TextFormField(
          onChanged: (searchValue) {
            print(searchValue);
            if (searchValue.length >= 2) {
              b2bsearchController.getSearchProdouctUsingApi(searchValue);
            } else if (searchValue.isEmpty) {
              b2bsearchController.getSearchProdouctUsingApi(searchValue);
            }
          },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: greenColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: greenColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: greenColor),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                )),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search Product',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: TextStyle(fontSize: 17),
          cursorColor: greyColor,
          enabled: true,
        ),
      ),
    );
  }
}
