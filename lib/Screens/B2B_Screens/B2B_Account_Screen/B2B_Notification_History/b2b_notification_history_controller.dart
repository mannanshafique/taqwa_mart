import 'dart:convert';

import 'package:get/get.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Model/Notification_Model/notification_model.dart';

class B2BNotificationController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Notification> notificationList = <Notification>[].obs;

  Future getNotificationHistory() async {
    isLoading.value = true;
    var responseNotificationHistory =
        await B2BNotificationHistoryFetch().getB2BNotificationHistoryApi();
    if (responseNotificationHistory.statusCode == 200) {
      isLoading.value = false;
      var jsonData = jsonDecode(responseNotificationHistory.body);
      print(jsonData);
      jsonData['Notifications'].forEach((element) {
        notificationList.add(Notification.fromJson(element));
      });
    }
  }

  @override
  void onInit() {
    getNotificationHistory();
    super.onInit();
  }
}
