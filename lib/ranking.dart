import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ecodot/widgets/top_menu.dart';
import 'widgets/bottom_navbar.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _Ranking();
}

class _Ranking extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TopMenu(),
        ),
        bottomNavigationBar: BottomNavBar(5),
        body: Text("Ranking"));
  }
}
