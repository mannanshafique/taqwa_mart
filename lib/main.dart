import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Services/Connectivity/internet_checker.dart';
import 'package:mangalo_app/Services/Notification/notification_service.dart';

import 'Screens/Splash _Screen/Splash_Ui/splash_ui.dart';
import 'Translation/language_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 Get.log('starting services ...');
//  Get.put(InternetChecker());
//  Get.put(NotificationService());


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taqwa Mart',
        translations: LanguageTranslation(),
        locale: Locale('en', 'US'),
        theme: appTheme,
        home: 
        // WaitingApproval(isWaitingApproval: false,)
        // SharedTesting(),
        // ReferScreen(),
        //     HomePage(
        //   pickUpLocation: 'asd',
        // ),
        // BottomNavigation(initailIndex: 0,),
        // NewUserLocationOption(),
        //OnBoardingScreen()
        // UserModeScreen()
        //  SettingScreen()
        //  ProfileScreen(),
        //  ProductDetailScreen(),
        // CategoryDetailScreen(),
        SplashScreen() //!--------------------------------B2C & B2B Final
        // B2BBottomNavigation(initailIndex: 0,),
        // BottomNavigationView(),
        );
  }
}
