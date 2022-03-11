import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreenController extends GetxController {
  RxString fullName = ''.obs;
  RxString storeName = ''.obs;
  RxString mobileNo = ''.obs;
  RxString address = ''.obs;
  //!-------Fetch Data From Shared Prefrences
  fetchDataFromSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    fullName.value = sharedPreferences.getString('b2buserName')!;
    storeName.value = sharedPreferences.getString('b2buserStoreName')!;
    mobileNo.value = sharedPreferences.getString('b2buserPhone')!;
    address.value = sharedPreferences.getString('b2buserAddress')!;
  }

  //!-------SignOut Remove Data From Shared Prefrences
  signout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  void onInit() {
    fetchDataFromSharedPref();
    super.onInit();
  }
}
