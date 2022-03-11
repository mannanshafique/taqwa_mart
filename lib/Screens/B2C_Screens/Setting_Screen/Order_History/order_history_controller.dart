import 'dart:convert';

import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/B2C_Order_History_Model/b2c_order_history_model.dart';

class OrderHistoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<B2COrderHistory> orderHistoryList = <B2COrderHistory>[].obs;

  Future getOrderHistory() async {
    isLoading.value = true;
    var responseOrderHistory =
        await OrderHistoryFetch().getOrderHistoryFetchApi();
    if (responseOrderHistory.statusCode == 200) {
      orderHistoryList.clear();
      isLoading.value = false;
      var jsonData = jsonDecode(responseOrderHistory.body);
      jsonData['OrderHistory'].forEach((element) {
        // print(element);
        orderHistoryList.add(B2COrderHistory.fromJson(element));
      });
    }
  }

  Future b2ccancelOrder({required String orderId}) async {
    //!------Cancel Order B2C
    var responseOrderCancel =
        await CancelOrder().postb2cCancelOrder(orderId.toString());
    if (responseOrderCancel.statusCode == 200) {
      getOrderHistory();
    } else {
      isLoading.value = false;
      Get.snackbar('Message', 'Something Went Wrong');
    }
  }

  @override
  void onInit() {
    getOrderHistory();
    super.onInit();
  }
}
