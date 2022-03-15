import 'package:get/get.dart';
import 'package:mangalo_app/Screens/User_Mode_Screen/user_mode_screen.dart';

class SplashController extends GetxController{
  @override
  void onInit() {
    delay();
    super.onInit();
  }

  delay(){
    //! Delay then move to next Screen
    Future.delayed(Duration(seconds: 8)).then((value) => Get.to(() => UserModeScreen()));
    // Future.delayed(Duration(seconds: 5)).then((value) => Get.to(() => OnBoardingScreen()));
    // Future.delayed(Duration(seconds: 5)).then((value) => Get.to(() => RegisterScreen()));
  }
}