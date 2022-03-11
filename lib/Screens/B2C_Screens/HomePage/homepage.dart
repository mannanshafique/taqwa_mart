import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/ProductModel/product_model.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/Cart_Controller/cart_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Product_Detail/Product_detail_controller/product_detail_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Product_Detail/product_detail.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Sub_Category_Detail/sub_cat_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'BottomNavigation/BottomNavigation.dart';
import 'HomePage_Controller/homepage_controller.dart';

class HomePage extends StatelessWidget {
  final String pickUpLocation;
  HomePage({Key? key, required this.pickUpLocation}) : super(key: key);

  // final homePageController = Get.put(HomePageController());
  final homePageController = Get.find<HomePageController>();
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CommonWidget()
          .roundBottomCornerappBar(70, 0.0, pickUpLocation, 0, context, false),
      body: SafeArea(
          child: Container(
        height: Get.height,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            //! ***Top Container  for swiper
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                child: Obx(
                  () => homePageController.bannerList.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                homePageController.bannerList[index],
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          itemCount: homePageController.bannerList.length,
                          pagination: SwiperPagination(
                              builder: const DotSwiperPaginationBuilder(
                                  size: 12.0,
                                  activeSize: 12.0,
                                  color: Colors.white,
                                  activeColor: Colors.green)),

                          // control: SwiperControl(),
                        ),
                )),

            //! ****** Category
            category(context),
            //! ****** Recommended
            recommended(),
          ],
        ),
      )),
    );
  }

//! Category Data
  Widget category(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget().customText(
                  'Shop by Category', blackColor, 22.0, FontWeight.w800, 1),
              GestureDetector(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: BottomNavigation(
                      initailIndex: 1,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );

                  //  Get.to(() => CategoryDetailScreen());
                },
                child: CommonWidget().customText(
                    'View all', greenColor, 18.0, FontWeight.w400, 1),
              ),
            ],
          ),
          CommonWidget().sizedBox(5.0, 0.0),

          Container(
              height: 160,
              child: Obx(
                () => GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.57
                        //! For Size MAnagment
                        ),
                    shrinkWrap: true,
                    itemCount: homePageController.categoryList.length,
                    itemBuilder: (context, index) {
                      var cat = homePageController.categoryList[index];
                      return categoryContainer(
                          cat.image, cat.name, cat.id.toString(), context);
                    }),
              ))
          // Container(
          //     height: 90,
          //     child: Obx(() => ListView.builder(
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         itemCount: homePageController.categoryList.length,
          //         itemBuilder: (context, index) {
          //           var cat = homePageController.categoryList[index];
          // return categoryContainer(
          //     cat.image, cat.name, cat.id.toString(), context);
          //         })))
        ],
      ),
    );
  }

  Widget categoryContainer(String imagePath, String name, String id, context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: lightgreyColor.withOpacity(0.1)),
      // width: 100,
      margin: EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          print('clicked');
          print(id);
          pushNewScreen(
            context,
            screen: SubCategoryDetailScreen(
              comingTabIndex: 0,
              pid: id,
              titleName: name,
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Container(
            margin: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: whiteColor),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: CommonWidget().customText(
                      name, blackColor, 15.0, FontWeight.w500, 2,
                      alignment: TextAlign.center),
                ),
                // Expanded(
                //     flex: 3,
                //     child:
                // Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Image.network(
                //         imagePath,
                //         fit: BoxFit.cover,
                //       ),
                //     )
                // ),
                // Expanded(
                //     flex: 2,
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 5, vertical: 0),
                //         child:
                // CommonWidget().customText(
                //             name, blackColor, 15.0, FontWeight.w500, 2),
                //       ),
                //     )),
              ],
            )),
      ),
    );
  }

  //! End Category Data
  //! Recommend For you
  Widget recommended() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonWidget().customText(
                  'Recommended for you', blackColor, 24.0, FontWeight.w700, 1),
            ],
          ),
          CommonWidget().sizedBox(5.0, 0.0),
          Container(
              height: 380, //! Controll the height of Recommand Container
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: homePageController.productList.length,
                  itemBuilder: (context, index) {
                    print('_-_-_-_-_-_-_-_-_-_-');
                    print(homePageController.productList[index].name);
                    print(homePageController
                        .productList[index].productAttributes[0].size);
                    print('_-_-_-_-_-_-_-_-_-_-');
                    return GestureDetector(
                      onTap: () {
                        Get.delete<ProductDetailController>();
                        pushNewScreen(
                          context,
                          screen: ProductDetailScreen(
                            name: homePageController.productList[index].name,
                            desc: homePageController
                                .productList[index].discription,
                            productAttrList: homePageController
                                .productList[index].productAttributes,
                            productId: homePageController.productList[index].id,
                          ),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: recommendedContainer(
                        homePageController
                            .productList[index].productAttributes[0].image,
                        homePageController.productList[index].name,
                        homePageController
                            .productList[index].productAttributes[0].price
                            .toString(),
                        homePageController.productList[index]
                            .productAttributes[0].discountPrice,
                        homePageController.productList[index]
                            .productAttributes[0].discountPercentage,
                        index,
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget recommendedContainer(
    String imagePath,
    String name,
    String retailprice,
    int discountPrice,
    int discountPercentage,
    index,
  ) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: lightgreyColor.withOpacity(0.1)),
      width: 160,
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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.network(
                      'http://165.227.69.207/zkadmin/public/uploads/$imagePath',
                      fit: BoxFit.cover,
                    ),
                  )),
              Expanded(
                  flex: 3,
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
                                  CommonWidget().customText(
                                      'Rs. $discountPrice',
                                      blackColor,
                                      20.0,
                                      FontWeight.w900,
                                      1),
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
                              name, blackColor, 16.0, FontWeight.normal, 3),
                        ),
                        CommonWidget().sizedBox(5.0, 0.0),
                        //!---------------------Weight Selection Box
                        Container(
                          padding: EdgeInsets.all(5.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5)),
                          //!------------------------------Weight Text
                          child: Text(
                              '${homePageController.productList[index].productAttributes[0].size.toString()} ${homePageController.productList[index].productAttributes[0].sizeType}'),
                        ),
                        //!-----------------------------------------
                        CommonWidget().sizedBox(5.0, 0.0),
                        //! Add to cart Button
                        addToCartButton(
                            homePageController,
                            index,
                            homePageController
                                .productList[index].productAttributes[0]),
                        CommonWidget().sizedBox(8.0, 0.0),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

//! ----Add to Cart
  Widget addToCartButton(
      homePageCategoryController, index, ProductAttribute productDetail) {
    return Obx(() {
      var itemListDetail;
      var isInCart = false;
      for (int i = 0; i < cartController.itemsList.length; i++) {
        if (homePageCategoryController.productList[index].name ==
            cartController.itemsList[i].name) {
          itemListDetail = cartController.itemsList[i];
          if (cartController.itemsList[i].isInCart) {
            isInCart = true;
          }
        } else {}
      }
      return (!isInCart)
          ? CommonWidget().addToCartContainer(0, () {
              print(productDetail.discountPrice);
              if (homePageCategoryController
                      .productList[index].productAttributes[0].stock ==
                  0) {
                Get.snackbar('Message', 'Product is Out of Stock');
              } else {
                cartController.addProduct(CartModel(
                  homePageCategoryController.productList[index].name,
                  1,
                  (productDetail.discountPrice.toString() == '0')
                      ? productDetail.price.toString()
                      : productDetail.discountPrice.toString(),
                  isInCart: true,
                  stock: homePageCategoryController
                      .productList[index].productAttributes[0].stock,
                  id: homePageCategoryController
                      .productList[index].productAttributes[0].id,
                  imagePath:
                      'http://165.227.69.207/zkadmin/public/uploads/${homePageController.productList[index].productAttributes[0].image}',
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

// ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minWidth: 40.0,
//                       maxWidth: 100.0,
//                       minHeight: 30.0,
//                       maxHeight: 60.0,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.network(
//                         imagePath,
//                         fit: BoxFit.cover,
//                       ),
//                     )),
