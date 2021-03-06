import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Account_Screen/B2B_Notification_History/b2b_notification_history_controller.dart';

class B2BNotificationHistory extends StatelessWidget {
  B2BNotificationHistory({Key? key}) : super(key: key);

  final b2bNotificationController = Get.put(B2BNotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications History',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          elevation: 0.0,
          backgroundColor: lightgreenColor,
        ),
        body: Obx(() => (b2bNotificationController.isLoading.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              )
            : (b2bNotificationController.notificationList.isEmpty)
                ? Center(
                    child: Text(
                      'No Notification Found',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        b2bNotificationController.notificationList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                            leading: CircleAvatar(
                              backgroundColor: whiteColor,
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/Images/taqwa_logo.png'),
                            ),
                            tileColor: lightgreyColor.withOpacity(0.1),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonWidget().customText('Taqwa Mart',
                                    blackColor, 18.0, FontWeight.w600, 1),
                                CommonWidget().customText(
                                    b2bNotificationController
                                        .notificationList[index].createdAt,
                                    greyColor,
                                    15.0,
                                    FontWeight.w300,
                                    1),
                              ],
                            ),
                            subtitle: CommonWidget().customText(
                                b2bNotificationController
                                    .notificationList[index].message
                                    .toString(),
                                blackColor,
                                16.0,
                                FontWeight.w300,
                                3),
                          ),
                        ),
                      );
                    },
                  )));
  }
}
