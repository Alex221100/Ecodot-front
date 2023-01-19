import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//call notification class in top_menu.dart

class TopMenu extends StatefulWidget {
  const TopMenu({super.key});
  @override
  State<TopMenu> createState() => _TopMenu();
}

class _TopMenu extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Image(image: AssetImage('assets/ecodot.png')),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            color: const Color.fromRGBO(83, 78, 89, 0.8),
            onPressed: () async {
              await showNotification();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/avatar-default.png'),
              ),
            ),
          ),
        )
      ],
      elevation: 0,
    );
  }

  Future<void> showNotification() async {
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
        AndroidInitializationSettings('ecodot_with_name');

    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
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
    //create notification details ios with darwin
    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinPlatformChannelSpecifics);
//show notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Veuillez dégivrer votre réfrigérateur',
      'Faites attention à votre consommation d\'énergie',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
