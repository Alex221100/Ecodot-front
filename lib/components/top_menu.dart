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
      title: const SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Image(image: AssetImage('ecodot.png')),
        ),
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
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            color: const Color.fromRGBO(83, 78, 89, 0.8),
            onPressed: () {},
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
                image: AssetImage('avatar-default.png'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
