import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//call notification class in top_menu.dart
import 'package:ecodot/screens/notification.dart' as notification;

class TopMenu extends StatefulWidget {
  const TopMenu({super.key});
  @override
  State<TopMenu> createState() => _TopMenu();
}

class _TopMenu extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      title: const Text(
        "Ecodot",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const notification.Notification()),
            );
          },
        ),
      ],
    );
  }
}
