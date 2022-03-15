import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Screens/Splash%20_Screen/Splash_Controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    //var heightapp = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: Get.height,
            width: double.infinity, //! Background Image
            color: whiteColor,
            child: Column(
              children: [
                //! **** First COntainer Image
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Image.asset(
                        'assets/Images/taqwa_mart_splash_.png',
                        alignment: Alignment.topCenter,
                      ),
                    )),
                //! **** Second COntainer Bottom Line
                Expanded(
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: blackColor,
                          height: 2,
                        )
                      ],
                    ),
                  )),
                )
              ],
            )),
      ),
    );
  }
}



//! ************* Custom Splash

// Expanded(
//                   child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Center(
//                   child: CustomSplash(
//                     // imagePath: 'Assets/images/splashLogo.png',
//                     // backGroundColor: Colors.green[400],
//                     backGroundColor: Colors.transparent,

//                     animationEffect: 'zoom-in',
//                     //logoSize: 20,
//                     home: null,
//                     duration: 5000,
//                     type: CustomSplashType.StaticDuration,
//                   ),
//                 ),
//               )),