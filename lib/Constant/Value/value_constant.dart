import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Color greenColor = Color(0xff44b623);
final Color lightgreenColor = Color(0xffC7FCB7).withOpacity(0.5);
final Color whiteColor = Colors.white;
final Color blackColor = Colors.black;
final Color? greyColor = Colors.grey[700];
final Color lightgreyColor = Colors.grey[700]!.withOpacity(0.5);
final Color lightredColor = Colors.red[100]!;

final imageStartUrl = 'https://mungalo-b2b.freshchoice.pk/public/uploads/';
// final imageStartUrl = 'http://165.227.69.207/mangalo_b2b/public/uploads/';
final b2CimageStartUrl = 'https://mungalo-b2c.freshchoice.pk/public/uploads/';
final b2bBaseUrl = 'https://mungalo-b2b.freshchoice.pk/public/api';
// final b2cBaseUrl = 'https://mungalo-b2c.freshchoice.pk/public/api';
final b2cBaseUrl = 'http://165.227.69.207/zkadmin/public/api';
// final b2bBaseUrl = 'http://165.227.69.207/mangalo_b2b/public/api';

//! App Theme
ThemeData appTheme = ThemeData.light().copyWith(
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Color(0xFFfdfdfd),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: lightgreenColor,
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: blackColor, fontSize: 18.0, fontWeight: FontWeight.bold),
    ));

Future<void> makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


//!-----Cancel Red Color
//!----Order Cancel With in 1 hour & b2c 5 Min
//!