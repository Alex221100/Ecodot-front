import 'package:ecodot/widgets/top_menu.dart';
import 'package:flutter/material.dart';
import 'widgets/bottom_navbar.dart';
import 'widgets/top_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ecodot',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: TopMenu(),
          ),
          bottomNavigationBar: BottomNavBar(0)),
    );
  }
}
