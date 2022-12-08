import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ecodot/widgets/top_menu.dart';
import 'widgets/bottom_navbar.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _Calculation();
}

class _Calculation extends State<Calculation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TopMenu(),
        ),
        bottomNavigationBar: BottomNavBar(1),
        body: Text("Calculation"));
  }
}
