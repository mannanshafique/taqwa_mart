import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/B2C_Order_History_Model/b2c_order_history_model.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/Cart_Controller/cart_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Checkout/checkout_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/BottomNavigation/BottomNavigation.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/HomePage_Controller/homepage_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Map/mapView.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({Key? key}) : super(key: key);

  final checkOutController = Get.put(CheckOutController());
  final cartContoller = Get.find<CartController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: CommonWidget().customText(
              'CheckOut Details', blackColor, 20.0, FontWeight.w500, 1,
              alignment: TextAlign.center),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //!--------------------------TextFields
                  //!----------User Name
                  CommonWidget().customText(
                      'User Name', greyColor, 20.0, FontWeight.normal, 1),
                  CommonWidget().sizedBox(5.0, 0.0),
                  Container(
                    height: 40.0,
                    width: Get.width,
                    child: CommonWidget().textField(
                        '',
                        checkOutController.userNameTextEditingController,
                        false, validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                    }, isEnable: true),
                  ),
                  CommonWidget().sizedBox(5.0, 0.0),

                  //!----------Phone
                  CommonWidget().customText(
                      'Phone', greyColor, 20.0, FontWeight.normal, 1),
                  CommonWidget().sizedBox(5.0, 0.0),
                  Container(
                    height: 40.0,
                    child: CommonWidget().textField(
                        '',
                        checkOutController.phoneTextEditingController,
                        false, validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone is required';
                      }
                    }, isEnable: true),
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  //!----------Address
                  CommonWidget().customText(
                      'Address', greyColor, 20.0, FontWeight.normal, 1),
                  CommonWidget().sizedBox(5.0, 0.0),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.delete<CheckOutController>();
                      pushNewScreen(
                        context,
                        screen: MapScreen(
                          isFromHomePage: false,
                          isFromCheckout: true,
                        ),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Container(
                      height: 50.0,
                      child: CommonWidget().textField(
                          '',
                          checkOutController.addressTextEditingController,
                          false,
                          validator: (value) {},
                          isEnable: false,
                          maxlines: 2),
                    ),
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  //!----------Additional Address
                  CommonWidget().customText('Additional Address', greyColor,
                      20.0, FontWeight.normal, 1),
                  CommonWidget().sizedBox(5.0, 0.0),
                  Container(
                    height: 40.0,
                    child: CommonWidget().textField(
                        '',
                        checkOutController
                            .additionalAddressTextEditingController,
                        false,
                        validator: (value) {},
                        isEnable: true,
                        maxlines: 1),
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  //!--------------------------End TextFields

                  //!----List Of Cart Items

                  cartItemList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidget().customText('Rider Charges : 100/-',
                          blackColor, 16.0, FontWeight.w300, 1),
                      CommonWidget().customText(
                          '${cartContoller.itemsList.length} Items',
                          greyColor,
                          18.0,
                          FontWeight.bold,
                          1),
                    ],
                  ),

                  CommonWidget().sizedBox(10.0, 0.0),
                  //!----Radio Button
                  Container(
                      width: Get.width,
                      height: 30.0,
                      child: Row(
                        children: [
                          CommonWidget().customText(
                              'Time: ', greyColor, 20.0, FontWeight.w500, 1),
                          Expanded(
                            child: Obx(
                              () => Container(
                                color: greyColor!.withOpacity(0.1),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount:
                                      checkOutController.deliverTimeList.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() => customRadioRow(
                                        text:
                                            '${checkOutController.deliverTimeList[index].times} Hrs',
                                        value: index));
                                  },
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  CommonWidget().sizedBox(10.0, 0.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        color: greyColor!.withOpacity(0.1),
                        child: CommonWidget().customText(
                            'Total : ${(cartContoller.totalprice > cartContoller.freeDeliveryAfter.value) ? cartContoller.totalprice.value : cartContoller.totalprice.value + cartContoller.deliveryCharges.value} /-',
                            blackColor,
                            20.0,
                            FontWeight.w500,
                            1),
                      ),
                    ],
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonWidget().customText('---*Cash on Delivery*---',
                          greyColor, 20.0, FontWeight.w500, 1),
                    ],
                  ),
                  CommonWidget().sizedBox(10.0, 0.0),
                  CommonWidget().button(
                      greenColor,
                      whiteColor,
                      'Proceed',
                      (cartContoller.isUserLogin.value)
                          ? () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                //!---------Order Creation As A Login User
                                var responseOrderCreation =
                                    await OrderCreation().orderCreation(
                                        additionalAddress: checkOutController
                                            .additionalAddressTextEditingController
                                            .text,
                                        deliveryCharges: (cartContoller
                                                    .totalprice >
                                                cartContoller
                                                    .freeDeliveryAfter.value)
                                            ? 0.0
                                            : cartContoller
                                                .deliveryCharges.value,
                                        deliveryTime: checkOutController
                                            .deliverTimeList[checkOutController
                                                .selectedRadio.value]
                                            .times,
                                        cartList: cartContoller.itemsList,
                                        subtotal: cartContoller.totalprice.value
                                            .toString());

                                if (responseOrderCreation.statusCode == 200) {
                                  Get.delete<HomePageController>();
                                  print(
                                      'order Creation Response ${responseOrderCreation.body}');
                                  cartContoller.itemsList.clear();
                                  cartContoller.totalprice.value = 0.0;
                                  Get.back();
                                  Get.dialog(CustomDialogue(
                                    title: 'Sucess',
                                    iconData: Icons.check,
                                    backColor: greenColor,
                                    subtitle: 'Your Order Placed Sucessfully',
                                  )).timeout(Duration(seconds: 4)).whenComplete(
                                      () => Get.off(() => BottomNavigation(
                                            initailIndex: 0,
                                          )));
                                } else {
                                  Get.back();
                                  Get.dialog(CustomDialogue(
                                    title: 'Failed',
                                    iconData: Icons.close,
                                    backColor: Colors.red,
                                    subtitle: 'Failed to Place Order',
                                  ))
                                      .timeout(Duration(seconds: 4))
                                      .whenComplete(() => Get.back());
                                }
                              }
                            }
                          : () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                //!---------Order Creation As A Guest User

                                var responseOrderCreation =
                                    await GuestOrderCreation().guestOrderCreation(
                                        additionalAddress: checkOutController
                                            .additionalAddressTextEditingController
                                            .text,
                                        guestName: checkOutController
                                            .userNameTextEditingController.text,
                                        guestPhone: checkOutController
                                            .phoneTextEditingController.text,
                                        deliveryCharges:
                                            (cartContoller.totalprice >
                                                    cartContoller
                                                        .freeDeliveryAfter
                                                        .value)
                                                ? 0.0
                                                : cartContoller
                                                    .deliveryCharges.value,
                                        deliveryTime: checkOutController
                                            .deliverTimeList[checkOutController.selectedRadio.value]
                                            .times,
                                        cartList: cartContoller.itemsList,
                                        subtotal: cartContoller.totalprice.value.toString());

                                if (responseOrderCreation.statusCode == 200) {
                                  RxList<B2COrderHistory> orderHistoryList =
                                      <B2COrderHistory>[].obs;
                                  var jsonData =
                                      jsonDecode(responseOrderCreation.body);
                                  orderHistoryList.add(B2COrderHistory.fromJson(
                                      jsonData['OrderHistory']));
                                  // jsonData['OrderHistory'].forEach((element) {
                                  //   // print(element);

                                  // });
                                  //!-------
                                  print(
                                      'order Creation Response ${responseOrderCreation.body}');
                                  cartContoller.itemsList.clear();
                                  cartContoller.totalprice.value = 0.0;
                                  Get.back();
                                  Get.dialog(CustomDialogue(
                                    title: 'Sucess',
                                    iconData: Icons.check,
                                    backColor: greenColor,
                                    subtitle: 'Your Order Placed Sucessfully',
                                  ))
                                      .timeout(Duration(seconds: 4))
                                      .whenComplete(() {
                                    Get.back();
                                    Get.dialog(historyDataContainer(
                                        orderHistory: orderHistoryList[0]));
                                  });
                                } else {
                                  Get.back();
                                  Get.dialog(CustomDialogue(
                                    title: 'Failed',
                                    iconData: Icons.close,
                                    backColor: Colors.red,
                                    subtitle: 'Failed to Place Order',
                                  ))
                                      .timeout(Duration(seconds: 4))
                                      .whenComplete(() => Get.back());
                                }
                              }
                            },
                      EdgeInsets.all(5),
                      20.0,
                      FontWeight.normal),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: -0.5,
            right: Get.width * 0.09,
            child: Container(
              height: Get.height * 0.1,
              width: Get.width * 0.1,
              decoration: new BoxDecoration(
                color: blackColor.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.delete<CheckOutController>();
                  },
                  child: Icon(
                    Icons.close,
                    color: whiteColor,
                    size: 20,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  customRadioRow({value, text}) {
    return Row(
      children: [
        customRadioButton(value: value),
        CommonWidget().sizedBox(0.0, 3.0),
        CommonWidget().customText(text, blackColor, 15.0, FontWeight.w400, 1,
            alignment: TextAlign.left),
        CommonWidget().sizedBox(0.0, 5.0),
      ],
    );
  }

  customRadioButton({required int value}) {
    return Radio(
      value: value,
      groupValue: checkOutController.selectedRadio.value,
      activeColor: greenColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      onChanged: (val) {
        checkOutController.setSelectedRadio(int.parse(val.toString()));
      },
    );
  }

// RoundedRectangleBorder(
//                                       side: BorderSide(
//                                     width: 1.5,
//                                     color: Colors.green.withOpacity(0.8),
//                                   )),
  Widget cartItemList() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: greenColor),
          color: greyColor!.withOpacity(0.06)),
      height: 90,
      width: Get.width,
      child: RawScrollbar(
          // controller: ScrollController(),
          // isAlwaysShown: true,
          thumbColor: greenColor,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartContoller.itemsList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      color: greenColor,
                      size: 16.0,
                    ),
                    CommonWidget().sizedBox(0.0, 10.0),
                    Expanded(
                      child: CommonWidget().customText(
                          '${cartContoller.itemsList[index].name.toString()}  (qty${cartContoller.itemsList[index].quantity.toString()})',
                          greyColor,
                          20.0,
                          FontWeight.normal,
                          2),
                    )
                  ],
                );
              })),
    );
  }

  //!-----_For History
  Widget historyDataContainer({required B2COrderHistory orderHistory}) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      color: whiteColor,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //!-------Order Number
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget().customText('Order No:',
                      blackColor.withOpacity(0.8), 18.0, FontWeight.bold, 1),
                  CommonWidget().sizedBox(0.0, 5.0),
                  CommonWidget().customText('(${orderHistory.orderNo})',
                      blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
                ],
              ),
              CommonWidget().sizedBox(10.0, 0.0),
              //!---------------Address--------(Start)
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  CommonWidget().sizedBox(0.0, 5.0),
                  Expanded(
                    child: CommonWidget().customText('${orderHistory.address}',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
                  ),
                ],
              ),
              //!---------------Address--------(End)
              CommonWidget().sizedBox(5.0, 0.0),
              //!--------Order Created & Delivered
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CommonWidget().customText(
                          'Created:',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.bold,
                          1),
                      CommonWidget().sizedBox(0.0, 5.0),
                      CommonWidget().customText(
                          '${orderHistory.createdAt}',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.w300,
                          1),
                    ],
                  ),
                  CommonWidget().sizedBox(5.0, 0.0),
                  Row(
                    children: [
                      CommonWidget().customText(
                          'Deliver:',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.bold,
                          1),
                      CommonWidget().sizedBox(0.0, 5.0),
                      CommonWidget().customText(
                          '${orderHistory.deliveryTime} Hrs',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.w300,
                          1),
                    ],
                  ),
                ],
              ),
              //!----End----Order Created & Delivered
              CommonWidget().sizedBox(5.0, 0.0),

              //!---------------Ordered Items---(start)
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orderHistory.orderDetail.length,
                  itemBuilder: (context, index) {
                    var orderDetail = orderHistory.orderDetail[index];
                    return itemCard(
                        itemImagePath: orderDetail.productDetail.image,
                        itemName: orderDetail.productDetail.product.name,
                        itemPrice: (orderDetail.productDetail.priceDiscount
                                .toString()
                                .isEmpty)
                            ? orderDetail.productDetail.priceRetail
                            : orderDetail.productDetail.priceDiscount,
                        itemQuantity:
                            int.parse(orderDetail.quantity.toString()));
                  }),
              //!---------------Ordered Items---(End)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //!-------------(Rider Charges)
                  Row(
                    children: [
                      CommonWidget().customText(
                          'Rider Charges:',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.w300,
                          1),
                      CommonWidget().sizedBox(0.0, 5.0),
                      CommonWidget().customText(
                          '${orderHistory.deliveryCharges.toString()}/-',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.bold,
                          1),
                    ],
                  ),

                  //!-------------(Items)
                  Row(
                    children: [
                      CommonWidget().customText(
                          orderHistory.orderDetail.length.toString(),
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.bold,
                          1),
                      CommonWidget().sizedBox(0.0, 5.0),
                      CommonWidget().customText(
                          'Items',
                          blackColor.withOpacity(0.8),
                          18.0,
                          FontWeight.w300,
                          1),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                padding: EdgeInsets.all(3.0),
                color: greyColor!.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonWidget().customText('Total Rs:',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
                    CommonWidget().sizedBox(0.0, 5.0),
                    CommonWidget().customText(
                        '${(double.parse(orderHistory.totalAmount) + double.parse(orderHistory.deliveryCharges)).toString()}/-',
                        blackColor.withOpacity(0.8),
                        18.0,
                        FontWeight.bold,
                        1),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     CommonWidget().customText('Total Rs:',
              //         blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
              //     CommonWidget().sizedBox(0.0, 5.0),
              //     CommonWidget().customText(
              //         '${orderHistory.totalAmount.toString()}/-',
              //         blackColor.withOpacity(0.8),
              //         18.0,
              //         FontWeight.bold,
              //         1),
              //   ],
              // ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40.0),
                child: CommonWidget()
                    .button(greenColor, whiteColor, 'Close Invoice', () async {
                  Get.back();
                }, EdgeInsets.symmetric(vertical: 8), 22.0, FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemCard({itemImagePath, itemName, itemPrice, int? itemQuantity}) {
    return Card(
      color: greyColor!.withOpacity(0.2),
      shape: RoundedRectangleBorder(
          side: BorderSide(
        width: 1.5,
        color: Colors.green.withOpacity(0.8),
      )),
      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: ListTile(
        tileColor: greyColor!.withOpacity(0.2),
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          child: Image.network("${b2CimageStartUrl + itemImagePath}"),
        ),
        title: Text(
          //! For Capitalization
          '${itemName![0].toUpperCase()}${itemName!.substring(1)}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Wrap(
          children: [
            Text('Rs. ${itemPrice.toString()}' +
                " x " +
                itemQuantity.toString() +
                " = "),
            Text(
              '(${itemQuantity! * int.parse(itemPrice.toString())} Rs)'
                  .toString(),
              style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
