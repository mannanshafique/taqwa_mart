import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/HomePage/BottomNavigation/BottomNavigation.dart';
import 'package:mangalo_app/Screens/B2C_Screens/New_User_Location_Option/new_user_location_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isBoarding = false;
 

  //! -----------Onboarding Data------
  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Center(
                    child: CommonWidget().customText('Choose from a broad',
                        greyColor, 25.0, FontWeight.w400, 1)),
                Wrap(
                  children: [
                    CommonWidget().customText(
                        'Range of ', greyColor, 25.0, FontWeight.w400, 1),
                    CommonWidget().customText('5,000+ Products', greenColor,
                        25.0, FontWeight.w600, 1),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bodyWidget: Center(child: Image.asset('assets/Images/onBoarding1.png')),
    ),
    PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Center(
                    child: CommonWidget().customText('Free Delivery for you',
                        greyColor, 25.0, FontWeight.w400, 1)),
                CommonWidget().customText(
                    'First order', greenColor, 25.0, FontWeight.w600, 1),
              ],
            ),
          ),
        ),
      ),
      bodyWidget: Center(child: Image.asset('assets/Images/onBoarding2.png')),
    ),
  ];
  //! -----------Onboarding Data End------

  onBoardingChecker() async {
    final sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getBool('onBoardingScreen') != null) {
      setState(() {
        isBoarding = false;
        Get.to(() => BottomNavigation(initailIndex: 0,),);
      });
    } else {
      setState(() {
        isBoarding = true;
      });
    }
  }
 
  @override
  void initState() {
    
    onBoardingChecker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: (isBoarding != true)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IntroductionScreen(
                  //! ***** Header
                  globalHeader: Container(
                    height: Get.height * 0.56,
                    color: greenColor.withOpacity(0.1),
                  ),

                  dotsDecorator: DotsDecorator(
                    activeColor: greenColor,
                  ),
                  pages: listPagesViewModel,
                  onDone: () {
                    // When done button is press
                  },
                  showDoneButton: true,
                  next: Text("Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: greenColor,
                      )),
                  showSkipButton: true,
                  skip: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.grey, fontSize: 19),
                  ),
                  done: GestureDetector(
                    onTap: () {
                      Get.to(() => NewUserLocationOption());
                    },
                    child: const Text("Done",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.green)),
                  ),
                )),
    );
  }
}
