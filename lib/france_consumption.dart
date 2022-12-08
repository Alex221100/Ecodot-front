import 'package:flutter/material.dart';
import 'package:ecodot/widgets/top_menu.dart';
import 'widgets/bottom_navbar.dart';

class FranceConsumption extends StatefulWidget {
  const FranceConsumption({super.key});

  @override
  State<FranceConsumption> createState() => _FranceConsumption();
}

class _FranceConsumption extends State<FranceConsumption> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TopMenu(),
        ),
        bottomNavigationBar: BottomNavBar(3),
        body: Text("FranceConsumption"));
  }
}
