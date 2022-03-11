import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/B2B_Contact_Us/b2b_contact_us.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/B2B_Notification_History/b2b_notifications_history.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/B2B_Order_History/b2b_order_history.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/account_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage_controller.dart';
import 'package:mangalo_app/Screens/User_Mode_Screen/user_mode_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'Profile_Screen/b2b_profile_screen.dart';
import 'Refer_Screen/refer_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final accountScreenController = Get.put(AccountScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        children: [
          stackImageContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                profileDetailRow(
                    'My Orders', 'assets/Images/Account_Icons/cart.png', () {
                  Get.to(() => B2BOrderHistory());
                }),
                // profileDetailRow('My Payments Card',
                //     'assets/Images/Account_Icons/payment_card.png', () {}),
                profileDetailRow('Notification',
                    'assets/Images/Account_Icons/notification.png', () {
                  Get.to(() => B2BNotificationHistory());
                }),
                profileDetailRow(
                    'Profile', 'assets/Images/Account_Icons/settings.png', () {
                  pushNewScreen(
                    context,
                    screen: B2BProfileScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }),
                profileDetailRow('Contact Us', 'assets/Images/contact_icon.png',
                    () {
                  pushNewScreen(
                    context,
                    screen: B2BContactUs(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }),
                profileDetailRow(
                    'Sign out', 'assets/Images/Account_Icons/sign_out.png', () {
                  accountScreenController.signout();
                  Get.delete<B2BHomePageController>();
                  Get.delete<B2BCartController>();
                  Get.delete<AccountScreenController>();
                  print('object');
                  Get.offAll(() => UserModeScreen());
                }),
              ],
            ),
          )
        ],
      )),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: greenColor,
      // toolbarHeight: 70,
      elevation: 0.0,
      centerTitle: true,
    );
  }

  Widget profileDetailRow(text, imagePath, onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset(
                    imagePath,
                    height: 20,
                    width: 20,
                  ),
                ),
                CommonWidget().sizedBox(0.0, 20.0),
                CommonWidget().customText(text, blackColor.withOpacity(0.8),
                    20.0, FontWeight.w500, 1),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: greyColor,
            )
          ],
        ),
      ),
    );
  }

  Widget stackImageContainer() {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            height: 70,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: whiteColor,
                    backgroundImage:
                        AssetImage('assets/Images/user_location.png'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommonWidget().customText(
                      accountScreenController.storeName.value,
                      blackColor,
                      20.0,
                      FontWeight.bold,
                      1)
                ],
              )),
        ],
      ),
    );
  }
}
