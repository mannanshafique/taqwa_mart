import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/B2B_Model/B2BProuctModel/b2b_product_model.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/B2B_Notification_History/b2b_notifications_history.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Bottom_Navigation/b2b_bottom_navigation.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Sub_Category/b2b_sub_category.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Sub_Category/b2b_sub_cateory_controller.dart';
import 'package:mangalo_app/Services/Notification/notification_service.dart';
import 'package:http/http.dart' as http;

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class B2BHomePage extends StatelessWidget {
  B2BHomePage({
    Key? key,
  }) : super(key: key);

  final b2bhomePageController = Get.put(B2BHomePageController());
  // final homePageController = Get.find<HomePageController>();
  final b2bcartController = Get.put(B2BCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text('homePage'.tr,
            style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.dialog(CommonWidget().languageAlertDialogue());
                },
                child: Icon(
                  Icons.language_outlined,
                  color: blackColor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () async {
                  await Get.to(() => B2BNotificationHistory());
                  http.Response notificationCountResponse =
                      await B2BNotificationCount().getNotificationCountApi();
                  var jsonData = jsonDecode(notificationCountResponse.body);
                  if (notificationCountResponse.statusCode == 200) {
                    print(notificationCountResponse.body);
                    notificationCount!.value = jsonData['unread_notifications'];
                    print('its NNN $notificationCount');
                  } else {
                    print(notificationCountResponse.body);
                  }
                },
                child: Badge(
                  position: BadgePosition.topEnd(top: -8, end: -4),
                  animationDuration: Duration(milliseconds: 300),
                  badgeColor: greenColor,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Obx(
                    () => CommonWidget().customText(
                        notificationCount!.value.toString(),
                        whiteColor,
                        15.0,
                        FontWeight.w400,
                        1),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: blackColor,
                  ),
                )),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        height: Get.height,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            //! ***Top Container  for swiper(BAnner)
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                child: Obx(
                  () => b2bhomePageController.b2bbannerList.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                b2bhomePageController.b2bbannerList[index],
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          itemCount: b2bhomePageController.b2bbannerList.length,
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
          (Get.locale!.languageCode == 'urd')
              ? Row(
                  //!------If Urdu
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!-----View All
                    GestureDetector(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: B2BBottomNavigation(
                            initailIndex: 1,
                          ),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: CommonWidget().customText(
                          'view_all'.tr, greenColor, 18.0, FontWeight.w400, 1),
                    ),
                    //!---Shop By Categ
                    CommonWidget().customText('shop_by_Category'.tr, blackColor,
                        22.0, FontWeight.w800, 1),
                  ],
                )
              : Row(
                  //!------If English
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget().customText('shop_by_Category'.tr, blackColor,
                        22.0, FontWeight.w800, 1),
                    GestureDetector(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: B2BBottomNavigation(
                            initailIndex: 1,
                          ),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
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
                    reverse: (Get.locale!.languageCode == 'urd') ? true : false,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.57
                        //! For Size MAnagment
                        ),
                    shrinkWrap: true,
                    itemCount: b2bhomePageController.b2bcategoryList.length,
                    itemBuilder: (context, index) {
                      var cat = b2bhomePageController.b2bcategoryList[index];
                      return categoryContainer(
                          cat.image, cat.name, cat.id.toString(), context);
                    }),
              ))
        ],
      ),
    );
  }

  Widget categoryContainer(String imagePath, String name, String id, context) {
    print('its Image Path $name $imagePath');
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: lightgreyColor.withOpacity(0.1)),
      // width: 100,
      margin: EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          print('clicked');
          Get.delete<B2BSubCategoryController>();
          print(id);
          pushNewScreen(
            context,
            screen: B2BSubCategoryDetailScreen(
              //!------Use for homepage to sub Category
              pid: 0.toString(),
              titleName: name,
              comingTabIndex: 0,
              id: id,
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
                    child: imagePath == imageStartUrl
                        ? Image.asset('assets/Images/logo_green.png')
                        : FadeInImage.assetNetwork(
                            placeholder: 'assets/Images/logo_green.png',
                            image: imagePath,
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
            mainAxisAlignment: (Get.locale!.languageCode == 'urd')
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              CommonWidget().customText('recommended_for_you'.tr, blackColor,
                  24.0, FontWeight.w700, 1),
            ],
          ),
          CommonWidget().sizedBox(5.0, 0.0),
          Container(
              height: 390, //! Controll the height of Recommand Container
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  reverse: (Get.locale!.languageCode == 'urd') ? true : false,
                  scrollDirection: Axis.horizontal,
                  itemCount: b2bhomePageController.productList.length,
                  itemBuilder: (context, index) {
                    print('_-_-_-_-_-_-_-_-_-_-');
                    print(b2bhomePageController.productList[index].name);
                    // print(b2bhomePageController
                    //     .productList[index].productAttributes[0].size);
                    print('_-_-_-_-_-_-_-_-_-_-');
                    return GestureDetector(
                      onTap: () {
                        //!--------------------(Detail Screen)
                        // pushNewScreen(
                        //   context,
                        //   screen: ProductDetailScreen(
                        //     name: b2bhomePageController.productList[index].name,
                        //     desc: b2bhomePageController
                        //         .productList[index].discription,
                        //     productAttrList: b2bhomePageController
                        //         .productList[index].productAttributes,
                        //     productId: b2bhomePageController.productList[index].id,
                        //   ),
                        //   withNavBar: true,
                        //   pageTransitionAnimation:
                        //       PageTransitionAnimation.cupertino,
                        // );
                      },
                      child: recommendedContainer(
                          b2bhomePageController.productList[index].image,
                          b2bhomePageController.productList[index].name,
                          b2bhomePageController.productList[index].priceRetail
                              .toString(),
                          b2bhomePageController
                              .productList[index].priceDiscount,
                          b2bhomePageController
                              .productList[index].discountPercent,
                          index,
                          '${b2bhomePageController.productList[index].unit} ${b2bhomePageController.productList[index].unitType}'),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget recommendedContainer(String imagePath, String name, String retailprice,
      int discountPrice, int discountPercentage, index, size) {
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
                      '$imagePath',
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
                              name, blackColor, 16.0, FontWeight.normal, 4),
                        ),
                        CommonWidget().sizedBox(5.0, 0.0),
                        //!---------------------Weight Selection Box
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(size.toString()),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                        //!-----------------------------------------
                        CommonWidget().sizedBox(5.0, 0.0),
                        //! Add to cart Button
                        addToCartButton(b2bhomePageController, index,
                            b2bhomePageController.productList[index]),
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
      homePageCategoryController, index, B2BProduct productDetail) {
    return Obx(() {
      var itemListDetail;
      var isInCart = false;
      for (int i = 0; i < b2bcartController.itemsList.length; i++) {
        if (homePageCategoryController.productList[index].id ==
            b2bcartController.itemsList[i].id) {
          itemListDetail = b2bcartController.itemsList[i];
          if (b2bcartController.itemsList[i].isInCart) {
            isInCart = true;
          }
        } else {}
      }
      return (!isInCart)
          ? CommonWidget().addToCartContainer(0, () {
              if (homePageCategoryController.productList[index].stock == 0) {
                Get.snackbar('Message', 'Product is Out of Stock');
              } else {
                b2bcartController.addProduct(B2BCartModel(
                  stock: homePageCategoryController.productList[index].stock,
                  name: homePageCategoryController.productList[index].name,
                  quantity: 1,
                  price: (productDetail.priceDiscount.toString().isEmpty)
                      ? productDetail.priceRetail.toString()
                      : productDetail.priceDiscount.toString(),
                  isInCart: true,
                  id: homePageCategoryController.productList[index].id,
                  imagePath:
                      '${homePageCategoryController.productList[index].image}',
                ));
              }
            }, () {}, () {}, () {}) //!
          : CommonWidget()
              .addToCartContainer(itemListDetail.quantity ?? 1, () {}, () {
              if (itemListDetail.stock == itemListDetail.quantity) {
              } else {
                b2bcartController.updateProduct(
                    //!------Increm Tap
                    itemListDetail,
                    itemListDetail.quantity! + 1);
              }
            }, () {
              b2bcartController.updateProduct(
                  itemListDetail, itemListDetail.quantity! - 1);
            }, () {
              b2bcartController.removeProduct(itemListDetail);
            });
    });
  }
}
