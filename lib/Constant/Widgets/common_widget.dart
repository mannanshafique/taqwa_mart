import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_AllCategoryView/b2b_allCateg_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_HomePage/b2b_homePage_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Login_Screen/login_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Checkout/checkout_screen.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Map/mapView.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Profile_Screen/profile_controller.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonWidget {
  Widget confirmationAlertDialogue(title, subtitle, onpressed) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.red),
        ),
      ),
      content: Text(
        subtitle,
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: lightredColor),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: blackColor),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: greenColor),
            onPressed: onpressed,
            child: Text('Ok')),
      ],
    );
  }

  //! Authenttication Used
  Widget textField(labeltext, controller, obsure,
      {required String? Function(String?) validator,
      isEnable,
      maxlength,
      maxlines}) {
    return TextFormField(
      maxLines: maxlines == null ? 1 : maxlines,
      obscureText: obsure,
      validator: validator,
      controller: controller,
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
        hintText: labeltext,
        enabled: isEnable == null ? true : isEnable,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(fontSize: 17),
      cursorColor: greyColor,
      maxLength: maxlength,
    );
  }

  //! ** Customize Text
  Widget customText(
      String text, color, double fontSize, fontWeight, int maxLines,
      {TextAlign? alignment}) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: alignment,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

//! *** CUstomize Button
  Widget button(buttonColor, textColor, buttonText, onPressed, padding,
      fontSize, fontweigth) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          primary: buttonColor,
        ),
        child: Padding(
          padding: padding,
          child: customText(buttonText, textColor, fontSize, fontweigth, 1),
        ),
      ),
    );
  }

//! *********Sized Box

  Widget sizedBox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget addToCartContainer(count, onTap, incTap, decTap, deleteTap) {
    //! if (count ==0 )  Add to cart Text Container
    return (count == 0)
        ? CommonWidget().button(greenColor, whiteColor, 'Add to cart', onTap,
            EdgeInsets.symmetric(vertical: 0), 18.0, FontWeight.normal)
        :
        //!  Add to cart Incr/Dec Button Container
        Container(
            height: 35,
            margin: EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: new Border.all(
                  color: greenColor, width: 2.2, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: (count == 1)
                      ? GestureDetector(
                          //! Delete Tap
                          onTap: deleteTap,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Image.asset('assets/Images/delete.png'),
                          ),
                        )
                      : GestureDetector(
                          //! Decrement Tap
                          onTap: decTap,
                          child: Icon(
                            Icons.remove,
                            color: greenColor,
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: CommonWidget().customText(
                      count.toString(), blackColor, 16.0, FontWeight.w500, 2),
                ),
                GestureDetector(
                  //! Increment Tap
                  onTap: incTap,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.add,
                      color: greenColor,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  //! -------------* Appbar Custom  0----> Location, 1---> Simple
  AppBar roundBottomCornerappBar(
      toolbarHeight, elevation, titleText, titleNumber, context, leading) {
    return AppBar(
      automaticallyImplyLeading: leading,
      backgroundColor: lightgreenColor,
      toolbarHeight: 70,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      )),
      title: (titleNumber == 1)
          ? Text(
              titleText,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print('Shared Clear');
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.clear();
                    },
                    child: Icon(
                      Icons.place_outlined,
                      color: greenColor,
                      size: 30,
                    ),
                  ),
                  CommonWidget().sizedBox(0.0, 3.0),
                  GestureDetector(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: MapScreen(
                          isFromHomePage: true,
                          isFromCheckout: false,
                        ),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                      // Get.to(() => MapScreen());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget().customText(
                            'Deliver to', blackColor, 18.0, FontWeight.w600, 1),
                        CommonWidget().sizedBox(3.0, 0.0),
                        Container(
                          width: Get.width * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonWidget().customText(titleText,
                                    greenColor, 16.0, FontWeight.w400, 1),
                              ),
                              CommonWidget().sizedBox(0.0, 3.0),
                              Center(
                                  child: Icon(
                                Icons.arrow_drop_down,
                                color: blackColor,
                                size: 22,
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  //! --------------* Bottom SHeet* ----------------------
  Widget bottomItemSheet() {
    return Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        // height: Get.height*0.45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(15.0, 0.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText('Select Size', blackColor, 20, FontWeight.bold, 1),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: greyColor!.withOpacity(0.5),
                      radius: 15,
                      child: Icon(
                        Icons.close,
                        color: whiteColor,
                      ),
                    ),
                  )
                ],
              ),
              customText(
                  'Olper full creamy milk', blackColor, 18, FontWeight.w300, 1),
              CommonWidget().sizedBox(5.0, 0.0),
              Expanded(
                child: ListView(
                  children: [
                    bottomSheetItemContainer(
                        'assets/Images/olper_milk.png', '1 ltr', 'Rs.250', 1),
                    bottomSheetItemContainer(
                        'assets/Images/olper_milk.png', '1 ltr', 'Rs.250', 0),
                    bottomSheetItemContainer(
                        'assets/Images/olper_milk.png', '1 ltr', 'Rs.250', 0),
                    bottomSheetItemContainer(
                        'assets/Images/olper_milk.png', '1 ltr', 'Rs.250', 0),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget bottomSheetItemContainer(
      imageText, productQuantity, productPrice, count) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 60,
                  child: Image.asset(imageText),
                ),
                CommonWidget().sizedBox(0.0, 10.0),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                          productQuantity, blackColor, 18, FontWeight.w300, 1),
                      customText(
                          productPrice, blackColor, 18, FontWeight.bold, 1),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              width: 130,
              child: addToCartContainer(count, () {}, () {}, () {}, () {})),
        ],
      ),
    );
  }
  //! --------------*End Bottom SHeet* ----------------------

//!----------Language Change---

  Widget languageAlertDialogue() {
    return AlertDialog(
      title: customText(
          'select_language'.tr, blackColor, 20.0, FontWeight.bold, 1),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          button(greenColor, whiteColor, 'english'.tr, () async {
            Get.back();
            Get.delete<B2BHomePageController>();
            Get.delete<B2BAllCategoryController>();
            Get.updateLocale(Locale('en', 'US'));
          }, EdgeInsets.symmetric(vertical: 8), 22.0, FontWeight.normal),
          sizedBox(10.0, 0.0),
          button(whiteColor, greenColor, 'urdu'.tr, () async {
            Get.back();
            Get.delete<B2BHomePageController>();
            Get.delete<B2BAllCategoryController>();
            Get.updateLocale(Locale('urd', 'PK'));
          }, EdgeInsets.symmetric(vertical: 8), 22.0, FontWeight.normal)
        ],
      ),
    );
  }
}

//!_--------------------Dialogue used in confirmation(login/register)
class CustomDialogue extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData iconData;
  final Color backColor;
  CustomDialogue(
      {required this.title,
      this.subtitle,
      required this.iconData,
      required this.backColor});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.height * 0.21,
        width: Get.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
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
                        child: Material(
                          child: Text(
                            title.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Material(
                          child: Text(
                            subtitle.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 20),
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: -40,
                    left: Get.width * 0.27,
                    child: Container(
                      height: Get.height * 0.1,
                      width: Get.width * 0.25,
                      decoration: new BoxDecoration(
                        color: backColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          iconData,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//!-----Used in b2b & b2c Profile Screen For Mobile Editing
class EditingAlertDialogue extends StatelessWidget {
  final profileController;
  EditingAlertDialogue({Key? key, required this.profileController})
      : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: CommonWidget().customText(
            'Detail Update', greenColor, 20.0, FontWeight.bold, 1,
            alignment: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50.0,
              child: Form(
                key: _formKey,
                child: CommonWidget().textField(
                    'Mobile No',
                    profileController.phoneTextEditingController,
                    false, validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Mobile No is Required';
                  }
                }),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            CommonWidget().button(greenColor, whiteColor, 'Update', () {
              if (!_formKey.currentState!.validate()) {
                return;
              } else {
                profileController.updateUserProfile(
                    phone: profileController.phoneTextEditingController.text);
                Get.back();
              }
            }, EdgeInsets.zero, 20.0, FontWeight.normal)
          ],
        ));
  }
}

//!--------------B2C checkout (Guest/Login) alert dailogue to confirm Guest & Login

Widget optionAlertDialogue() {
  return AlertDialog(
    title: CommonWidget()
        .customText('Select Mode', blackColor, 20.0, FontWeight.bold, 1),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidget().button(greenColor, whiteColor, 'Guest', () async {
          Get.back();
          Get.dialog(CheckOutScreen(), barrierDismissible: false);
        }, EdgeInsets.symmetric(vertical: 8), 22.0, FontWeight.normal),
        CommonWidget().sizedBox(10.0, 0.0),
        CommonWidget().button(whiteColor, greenColor, 'Login', () async {
          Get.back();
          Get.to(() => LoginScreen());
        }, EdgeInsets.symmetric(vertical: 8), 22.0, FontWeight.normal)
      ],
    ),
  );
}
