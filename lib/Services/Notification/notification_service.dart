import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Notification/notifications_ui.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';

RxInt? notificationCount = 0.obs;

class NotificationService extends GetxService {

  late FirebaseMessaging firebaseMessaging;
  notificationsFetcher() {
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) async {
       http.Response notificationCountResponse =
          await B2BNotificationCount().getNotificationCountApi();
      var jsonData = jsonDecode(notificationCountResponse.body);
      if (notificationCountResponse.statusCode == 200) {
        print(notificationCountResponse.body);
        notificationCount!.value = jsonData['unread_notifications'];
        print('its NNN $notificationCount');
      } else {
        print(notificationCountResponse.body);
      }
      print('its Token $value');
      FirebaseMessaging.onMessage.listen((RemoteMessage event) async{
        http.Response notificationCountResponse =
          await B2BNotificationCount().getNotificationCountApi();
      var jsonData = jsonDecode(notificationCountResponse.body);
      if (notificationCountResponse.statusCode == 200) {
        print(notificationCountResponse.body);
        notificationCount!.value = jsonData['unread_notifications'];
        print('its NNN $notificationCount');
      } else {
        print(notificationCountResponse.body);
      }
        print("message recieved");
        print(event.notification!.body);
        createNotificationsPopUp(
            title: event.notification!.title,
            description: event.notification!.body);
      });
    });
  }

  awesomenotificationInitializing() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/launcher_icon',

        // null,
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: greenColor,
            ledColor: Colors.white,
          ),
        ]);
  }

  @override
  void onInit() {
    awesomenotificationInitializing();
    notificationsFetcher();
    super.onInit();
  }
}
