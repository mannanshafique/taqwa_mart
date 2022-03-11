import 'package:get/get.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/Cart_Controller/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreenController extends GetxController {
  final cartController = Get.find<CartController>();

  late SharedPreferences sharedPreferences;
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString mobileNo = ''.obs;
  RxString address = ''.obs;
  RxBool isUserLogin = false.obs;

  //!-------Fetch Data From Shared Prefrences
  fetchDataFromSharedPref() async {
     sharedPreferences = await SharedPreferences.getInstance();
    fullName.value = sharedPreferences.getString('userName')!;
    email.value = sharedPreferences.getString('userEmail')!;
    mobileNo.value = sharedPreferences.getString('userPhone')!;
    address.value = sharedPreferences.getString('updatedAddress')!;
  }

  //!-------SignOut Remove Data From Shared Prefrences
  signout() async {
     sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  checkLoginStatus() async {
    print('Check User Status');
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userEmail") == null) {
      isUserLogin.value  = false;
    } else {
      isUserLogin.value  = true;
      cartController.isUserLogin.value = true;
    }
  }

  Future<void> pullRefresh() async {
   await checkLoginStatus();
  }

  @override
  void onInit() {
    fetchDataFromSharedPref();
    checkLoginStatus();
    
    super.onInit();
  }
}
