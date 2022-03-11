import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Setting_Screen/Notification_history/notification_history_controller.dart';

class NotificationHistory extends StatelessWidget {
  NotificationHistory({Key? key}) : super(key: key);

  final notificationController = Get.put(NotificationController());

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
        body: Obx(() => (notificationController.isLoading.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              )
            : (notificationController.notificationList.isEmpty)
                ? Center(
                    child: Text(
                      'No Notification Found',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        notificationController.notificationList.length,
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
                                  AssetImage('assets/Images/logo_green.png'),
                            ),
                            tileColor: lightgreenColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonWidget().customText('Mungalo', blackColor,
                                    18.0, FontWeight.w600, 1),
                                CommonWidget().customText(
                                    notificationController
                                        .notificationList[index].createdAt,
                                    greyColor,
                                    15.0,
                                    FontWeight.w300,
                                    1),
                              ],
                            ),
                            subtitle: CommonWidget().customText(
                                notificationController
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
