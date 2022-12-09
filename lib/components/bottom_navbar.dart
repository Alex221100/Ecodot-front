import 'package:flutter/material.dart';
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import 'package:ecodot/screens/calculation.dart';
import 'package:ecodot/screens/france_consumption.dart';
import 'package:ecodot/screens/home.dart';
import 'package:ecodot/screens/my_consumption.dart';
import 'package:ecodot/screens/ranking.dart';
import 'package:ecodot/utils/constants.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: const [
        Calculation(),
        FranceConsumption(),
        Home(),
        MyConsumption(),
        Ranking()
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calculate_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.flag_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.donut_small_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.leaderboard_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        )
      ],
      margin: const EdgeInsets.all(30),
      confineInSafeArea: false,
      navBarStyle: NavBarStyle.style5,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: MyColor.background,
      ),
    );
  }
}
