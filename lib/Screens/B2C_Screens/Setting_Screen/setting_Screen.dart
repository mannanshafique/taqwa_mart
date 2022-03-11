import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Login_Screen/login_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Contact_Us/contact_us.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Notification_history/notification_history.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Order_History/order_history.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Profile_Screen/profile_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/setting_controller.dart';
import 'package:mangalo_app/Screens/User_Mode_Screen/user_mode_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'Notification_history/notification_history_controller.dart';
import 'Profile_Screen/profile_screen.dart';
import 'Refer_Screen/refer_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final settingScreenController = Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: settingScreenController.pullRefresh,
        child: SafeArea(
            child: (settingScreenController.isUserLogin.value)
                ? ListView(
                    shrinkWrap: true,
                    children: [
                      stackImageContainer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: Column(
                          children: [
                            profileDetailRow('My Orders',
                                'assets/Images/Account_Icons/cart.png', () {
                              Get.to(() => OrderHistoryScreen());
                            }),
                            profileDetailRow('Notifications',
                                'assets/Images/Account_Icons/notification.png',
                                () {
                              Get.delete<NotificationController>();
                              pushNewScreen(
                                context,
                                screen: NotificationHistory(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }),
                            // profileDetailRow('My Addresses',
                            //     'assets/Images/locationIcon.png', () {}),
                            profileDetailRow('Invite a Friend',
                                'assets/Images/Account_Icons/invite_friend.png',
                                () {
                              pushNewScreen(
                                context,
                                screen: ReferScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }),
                            profileDetailRow('Profile',
                                'assets/Images/Account_Icons/settings.png', () {
                              Get.delete<ProfileController>();
                              pushNewScreen(
                                context,
                                screen: ProfileScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }),
                            profileDetailRow(
                                'Contact Us', 'assets/Images/contact_icon.png',
                                () {
                              pushNewScreen(
                                context,
                                screen: ContactUs(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }),
                            profileDetailRow('Sign out',
                                'assets/Images/Account_Icons/sign_out.png', () {
                              settingScreenController.signout();
                              Get.offAll(() => UserModeScreen());
                            }),
                          ],
                        ),
                      )
                    ],
                  )
                : AlertDialog(
                    content: LoginAlertDialogue(),
                  )),
      ),
    );
  }

  AppBar appBar() {
    return (settingScreenController.isUserLogin.value)
        ? AppBar(
            backgroundColor: greenColor,
            elevation: 0.0,
            centerTitle: true,
          )
        : AppBar(
            backgroundColor: lightgreenColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text('Login'),
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
                    height: 25,
                    width: 25,
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
                    backgroundImage: AssetImage('assets/Images/logo_green.png'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(() => CommonWidget().customText(
                      settingScreenController.fullName.value,
                      blackColor,
                      20.0,
                      FontWeight.bold,
                      1))
                ],
              )),
        ],
      ),
    );
  }
}

//! ------------------If User not login then show altert dialogue to login
class LoginAlertDialogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Authentication',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'This Screen requires Login to Access',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 20),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        //overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
