import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ecodot/widgets/top_menu.dart';
import 'widgets/bottom_navbar.dart';

class MyConsumption extends StatefulWidget {
  const MyConsumption({super.key});

  @override
  State<MyConsumption> createState() => _MyConsumption();
}

class _MyConsumption extends State<MyConsumption> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TopMenu(),
        ),
        bottomNavigationBar: BottomNavBar(4),
        body: Text("myConsumption"));
  }
}
