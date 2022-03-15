import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/Order_History_Model/order_history_model.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/B2B_Order_History/b2b_order_history_controller.dart';

class B2BOrderHistory extends StatelessWidget {
  B2BOrderHistory({Key? key}) : super(key: key);
  final b2bOrderHistoryController = Get.put(B2BOrderHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0.0,
        backgroundColor: lightgreenColor,
      ),
      body: Container(height: Get.height, child: historyList(context)),
      // Container(
      //     height: Get.height * 0.8, width: Get.width, child: historyList()),
    );
  }

  Widget historyList(context) {
    return Obx(() => (b2bOrderHistoryController.isLoading.value)
        ? Center(
            child: CircularProgressIndicator(
              color: greenColor,
            ),
          )
        : (b2bOrderHistoryController.orderHistoryList.isEmpty)
            ? Center(
                child: Text(
                  'No History Found',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: b2bOrderHistoryController.orderHistoryList.length,
                itemBuilder: (context, index) {
                  return historyDataContainer(
                      orderHistory:
                          b2bOrderHistoryController.orderHistoryList[index]);
                }));
  }

  Widget historyDataContainer({required OrderHistory orderHistory}) {
    bool isCancelShow;
    var formatHourly = DateFormat('dd-MM-yy h:m');
    var orderCreatedTime = formatHourly.format(orderHistory.createdAt);
    var currentTime = formatHourly.format(DateTime.now());
    // var currentTimeDate = formatHourly.parse(currentTime.toString());
    int finalDays = formatHourly
        .parse(currentTime)
        .difference(formatHourly.parse(orderCreatedTime))
        .inDays;
    int finalTimeInMint = formatHourly
        .parse(currentTime)
        .difference(formatHourly.parse(orderCreatedTime))
        .inMinutes;
    // print(
    //     ' ${orderHistory.orderNo} || ${formatHourly.parse(currentTime).difference(formatHourly.parse(orderCreatedTime)).inDays}');
    if (finalDays == 0 && finalTimeInMint < 60) {
      print('Time Remaing${orderHistory.orderNo}');
      isCancelShow = true;
    } else {
      print('Time Up ${orderHistory.orderNo}');
      isCancelShow = false;
    }
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      color: orderHistory.cancellAt == '' ? lightgreen : lightredColor,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //!-------Order Number
            Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonWidget().customText('Order No:',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.bold, 1),
                    CommonWidget().sizedBox(0.0, 5.0),
                    CommonWidget().customText('(${orderHistory.orderNo})',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
                    CommonWidget().sizedBox(0.0, 5.0),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    orderHistory.cancellAt == ''
                        ? isCancelShow
                            ? Container(
                                width: 80.0,
                                height: 30.0,
                                child: CommonWidget().button(
                                    Colors.red, whiteColor, 'Cancel', () {
                                  Get.dialog(CommonWidget()
                                      .confirmationAlertDialogue('Alert',
                                          'Are You Sure to Cancel That Order',
                                          () {
                                    Get.back();
                                    b2bOrderHistoryController.cancelOrder(
                                        orderId: orderHistory.id.toString());
                                  }));
                                }, EdgeInsets.zero, 15.0, FontWeight.bold),
                              )
                            : Container()
                        : Container(
                            width: 100.0,
                            height: 30.0,
                            child: CommonWidget().button(
                                Colors.grey[400],
                                blackColor.withOpacity(0.8),
                                'Canceled',
                                () {},
                                EdgeInsets.zero,
                                15.0,
                                FontWeight.bold),
                          )
                    // CommonWidget().customText(
                    //     orderHistory.cancellAt == '' ? '' : '(Canceled)',
                    //     blackColor.withOpacity(0.8),
                    //     18.0,
                    //     FontWeight.w600,
                    //     1),
                  ],
                )
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
                    CommonWidget().customText('Created:',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.bold, 1),
                    CommonWidget().sizedBox(0.0, 5.0),
                    CommonWidget().customText(
                        '${DateFormat('dd-MM-yy ( h:m:a )').format(orderHistory.createdAt).toString()}',
                        blackColor.withOpacity(0.8),
                        18.0,
                        FontWeight.w300,
                        1),
                  ],
                ),
                CommonWidget().sizedBox(5.0, 0.0),
                Row(
                  children: [
                    CommonWidget().customText('Delivery Time:',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.bold, 1),
                    CommonWidget().sizedBox(0.0, 5.0),
                    CommonWidget().customText('24 Hr',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
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
                      itemName: orderDetail.productDetail.name,
                      itemPrice: (orderDetail.productDetail.priceDiscount
                              .toString()
                              .isEmpty)
                          ? orderDetail.productDetail.priceRetail
                          : orderDetail.productDetail.priceDiscount,
                      itemQuantity: int.parse(orderDetail.quantity.toString()));
                }),
            //!---------------Ordered Items---(End)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //!-------------(Rider Charges)
                Row(
                  children: [
                    CommonWidget().customText('Rider Charges:',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
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
                    CommonWidget().customText('Items',
                        blackColor.withOpacity(0.8), 18.0, FontWeight.w300, 1),
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
          ],
        ),
      ),
    );
  }

  Widget itemCard({itemImagePath, itemName, itemPrice, int? itemQuantity}) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
        width: 1.5,
        color: Colors.green.withOpacity(0.8),
      )),
      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          child: Image.network("${imageStartUrl + itemImagePath}"),
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
