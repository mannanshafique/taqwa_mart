import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/BottomNavigation/BottomNavigation.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Map/Map_Controller/mapController.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Map/mapView.dart';

class NewUserLocationOption extends StatelessWidget {
  NewUserLocationOption({Key? key}) : super(key: key);
  final locationPickerController = Get.put(LocationPickerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //! ****** Stack Image With Green Background
            Container(
              height: Get.height * 0.4,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: Get.height * 0.3,
                    color: greenColor.withOpacity(0.1),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset('assets/Images/user_location.png'),
                    ),
                  ),
                ],
              ),
            ),
            //! ****** End Stack Image With Green Background
            Column(
              children: [
                CommonWidget().customText('Taqwa Mart requires access',
                    blackColor, 28.0, FontWeight.w400, 1),
                CommonWidget().sizedBox(2.0, 0.0),
                CommonWidget().customText(
                    'to your location', blackColor, 28.0, FontWeight.w400, 1),
                CommonWidget().sizedBox(10.0, 0.0),
                CommonWidget().customText('We would like to access your',
                    greyColor, 20.0, FontWeight.w400, 1),
                CommonWidget().customText('location so you can view products',
                    greyColor, 20.0, FontWeight.w400, 1),
                CommonWidget().customText('that are available near you.',
                    greyColor, 20.0, FontWeight.w400, 1),
              ],
            ),
            //! *******Buttons
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonWidget().sizedBox(20.0, 0.0),
                    CommonWidget().button(
                        greenColor, whiteColor, 'Use current location', () {
                      Get.offAll(() => BottomNavigation(
                            initailIndex: 0,
                          ));
                    }, EdgeInsets.symmetric(vertical: 12), 22.0,
                        FontWeight.normal),
                    CommonWidget().sizedBox(20.0, 0.0),
                    CommonWidget().button(
                        whiteColor, blackColor, 'Select location manually', () {
                      Get.to(() => MapScreen(
                            isFromHomePage: false,
                            isFromCheckout: false,
                          ));
                    }, EdgeInsets.symmetric(vertical: 12), 22.0,
                        FontWeight.normal),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
