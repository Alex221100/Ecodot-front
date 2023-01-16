//create notification class
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//solve me Unhandled Exception: Invalid argument(s): iOS settings must be set when targeting iOS platform error
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  _Notification createState() => _Notification();
}

class _Notification extends State<Notification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await showNotification();
          },
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}

Future<void> showNotification() async {
  
//initialize notification plugin

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  
    FlutterLocalNotificationsPlugin();
//create notification channel
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
//initialize notification channel
await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);
//initialize notification settings
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
final InitializationSettings initializationSettings =

    InitializationSettings(android: initializationSettingsAndroid);
await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//create notification details
const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
  'your channel id', // id
  'your channel name', // title
  importance: Importance.max,
  priority: Priority.high,
  showWhen: false,
);
const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
//show notification
await flutterLocalNotificationsPlugin.show(
  0,
  'plain title',
  'plain body',
  platformChannelSpecifics,
  payload: 'item x',
);

}
