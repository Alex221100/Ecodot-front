import 'package:flutter/material.dart';
import 'package:ecodot/widgets/top_menu.dart';
import 'widgets/bottom_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TopMenu(),
        ),
        bottomNavigationBar: BottomNavBar(3),
        body: Text("home"));
  }
}
