import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createNotificationsPopUp({title, description}) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: 1,
    channelKey: 'basic_channel',
    title: title,
    body: description,
    // bigPicture: 'asset://assets/Images/logo_green.png',
    largeIcon: 'asset://assets/Images/taqwa_logo.png',
    // notificationLayout: NotificationLayout.BigPicture,
  ));
}
