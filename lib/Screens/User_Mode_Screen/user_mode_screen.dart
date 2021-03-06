import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/B2B_Login/b2b_login_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/OnBoarding_Screen/on_boarding_screen.dart';

class UserModeScreen extends StatelessWidget {
  const UserModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: Get.height,
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: CommonWidget().customText(
                                  'Select your',
                                  greyColor!.withOpacity(0.7),
                                  25,
                                  FontWeight.w500,
                                  1),
                            ),
                            Center(
                              child: CommonWidget().customText(
                                  'User mode screen',
                                  greyColor!.withOpacity(0.7),
                                  25,
                                  FontWeight.w500,
                                  1),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            //!------------------Household Buttton
                            CommonWidget().button(
                                greenColor, whiteColor, 'Household', () {
                              Get.to(() => OnBoardingScreen());
                            }, EdgeInsets.symmetric(vertical: 12), 22.0,
                                FontWeight.normal),
                            CommonWidget().sizedBox(20.0, 0.0),
                            //!------------------Wholesaler Buttton
                            CommonWidget().button(
                                whiteColor, blackColor, 'Retailer / Wholesaler',
                                () {
                              Get.to(() => B2BLoginScreen());
                            }, EdgeInsets.symmetric(vertical: 12), 22.0,
                                FontWeight.normal),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                    //color: Colors.pink,
                    child: Image.asset('assets/Images/user_mode.png')))
          ],
        ),
      )),
    );
  }
}
