import 'dart:convert';

import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/Order_History_Model/order_history_model.dart';

class B2BOrderHistoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<OrderHistory> orderHistoryList = <OrderHistory>[].obs;

  Future getOrderHistory() async {
    isLoading.value = true;
    var responseOrderHistory =
        await B2BOrderHistoryFetch().getB2BOrderHistoryFetchApi();
    if (responseOrderHistory.statusCode == 200) {
      orderHistoryList.clear();
      isLoading.value = false;
      var jsonData = jsonDecode(responseOrderHistory.body);
      jsonData['OrderHistory'].forEach((element) {
        orderHistoryList.add(OrderHistory.fromJson(element));
      });
    } else {
      isLoading.value = false;
    }
  }

  Future cancelOrder({required String orderId}) async {
    //!------Cancel Order
    var responseOrderCancel =
        await B2BCancelOrder().postB2BCancelOrder(orderId.toString());
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
