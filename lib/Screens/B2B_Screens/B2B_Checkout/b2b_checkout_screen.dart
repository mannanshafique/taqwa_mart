import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Bottom_Navigation/b2b_bottom_navigation.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Checkout/b2b_checkout_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage_controller.dart';

class B2BCheckOutScreen extends StatelessWidget {
  B2BCheckOutScreen({Key? key}) : super(key: key);

  final b2BCheckOutController = Get.put(B2BCheckOutController());
  final b2bCartContoller = Get.find<B2BCartController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: CommonWidget().customText(
          'CheckOut Details', blackColor, 20.0, FontWeight.w500, 1,
          alignment: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //!--------------------------TextFields
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!----------User Name
                    CommonWidget().customText(
                        'User Name', greyColor, 20.0, FontWeight.normal, 1),
                    CommonWidget().sizedBox(5.0, 0.0),
                    Container(
                      height: 40.0,
                      width: Get.width * 0.32,
                      child: CommonWidget().textField(
                          '',
                          b2BCheckOutController.userNameTextEditingController,
                          false,
                          validator: (value) {},
                          isEnable: false),
                    ),
                  ],
                ),
                CommonWidget().sizedBox(0.0, 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!----------Store Name
                    CommonWidget().customText(
                        'Store Name', greyColor, 20.0, FontWeight.normal, 1),
                    CommonWidget().sizedBox(5.0, 0.0),
                    Container(
                      height: 40.0,
                      width: Get.width * 0.32,
                      child: CommonWidget().textField(
                          '',
                          b2BCheckOutController.storeNameTextEditingController,
                          false,
                          validator: (value) {},
                          isEnable: false),
                    ),
                  ],
                ),
              ],
            ),
            CommonWidget().sizedBox(5.0, 0.0),

            // Row(
            //   children: [

            //     CommonWidget().sizedBox(10.0, 0.0),

            //   ],
            // ),

            //!----------Phone
            CommonWidget()
                .customText('Phone', greyColor, 20.0, FontWeight.normal, 1),
            CommonWidget().sizedBox(5.0, 0.0),
            Container(
              height: 40.0,
              child: CommonWidget().textField(
                  '', b2BCheckOutController.phoneTextEditingController, false,
                  validator: (value) {}, isEnable: true),
            ),
            CommonWidget().sizedBox(10.0, 0.0),
            //!----------Address
            CommonWidget()
                .customText('Address', greyColor, 20.0, FontWeight.normal, 1),
            CommonWidget().sizedBox(5.0, 0.0),
            Container(
              height: 50.0,
              child: CommonWidget().textField(
                  '', b2BCheckOutController.addressTextEditingController, false,
                  validator: (value) {}, isEnable: false, maxlines: 2),
            ),
            CommonWidget().sizedBox(10.0, 0.0),
            //!--------------------------End TextFields

            //!----List Of Cart Items

            cartItemList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidget().customText(
                    'Rider Charges : ${(b2bCartContoller.totalprice > b2bCartContoller.freeDeliveryAfter.value) ? '0' : b2bCartContoller.deliveryCharges.value}/-',
                    blackColor,
                    16.0,
                    FontWeight.w300,
                    1),
                CommonWidget().customText(
                    '${b2bCartContoller.itemsList.length} Items',
                    greyColor,
                    18.0,
                    FontWeight.bold,
                    1),
              ],
            ),

            CommonWidget().sizedBox(10.0, 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: greyColor!.withOpacity(0.1),
                  child: CommonWidget().customText(
                      'Total : ${(b2bCartContoller.totalprice > b2bCartContoller.freeDeliveryAfter.value) ? b2bCartContoller.totalprice.value : b2bCartContoller.totalprice.value + b2bCartContoller.deliveryCharges.value} /-',
                      blackColor,
                      18.0,
                      FontWeight.w500,
                      1),
                ),
              ],
            ),
            CommonWidget().sizedBox(10.0, 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonWidget().customText('---*Cash on Delivery*---', greyColor,
                    20.0, FontWeight.w500, 1),
              ],
            ),
            CommonWidget().sizedBox(10.0, 0.0),
            CommonWidget().button(greenColor, whiteColor, 'Proceed', () async {
              var responseOrderCreation = await B2BOrderCreation()
                  .b2bOrderCreation(
                      deliveryCharges: (b2bCartContoller.totalprice >
                              b2bCartContoller.freeDeliveryAfter.value)
                          ? 0.0
                          : b2bCartContoller.deliveryCharges.value,
                      b2bCartList: b2bCartContoller.itemsList,
                      subtotal: b2bCartContoller.totalprice.value.toString());

              if (responseOrderCreation.statusCode == 200) {
                Get.delete<B2BHomePageController>();
                print('order Creation Response ${responseOrderCreation.body}');
                b2bCartContoller.totalprice.value = 0.0;
                Get.back();
                b2bCartContoller.itemsList.clear();
                Get.dialog(CustomDialogue(
                  title: 'Sucess',
                  iconData: Icons.check,
                  backColor: greenColor,
                  subtitle: 'Your Order Placed Sucessfully',
                ))
                    .timeout(Duration(seconds: 4))
                    .whenComplete(() => Get.off(() => B2BBottomNavigation(
                          initailIndex: 0,
                        )));
              } else {
                Get.dialog(CustomDialogue(
                  title: 'Failed',
                  iconData: Icons.close,
                  backColor: Colors.red,
                  subtitle: 'Failed to Place Order',
                )).timeout(Duration(seconds: 4)).whenComplete(() => Get.back());
              }
            }, EdgeInsets.all(5), 20.0, FontWeight.normal),
          ],
        ),
      ),
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
      height: Get.height * 0.2,
      width: Get.width,
      child: RawScrollbar(
          // controller: ScrollController(),
          // isAlwaysShown: true,
          thumbColor: greenColor,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: b2bCartContoller.itemsList.length,
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
                          '${b2bCartContoller.itemsList[index].name.toString()}  (qty${b2bCartContoller.itemsList[index].quantity.toString()})',
                          greyColor,
                          20.0,
                          FontWeight.normal,
                          2),
                    ),
                  ],
                );
              })),
    );
  }
}
