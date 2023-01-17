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
        Home(),
        MyConsumption(),
        Ranking(),
        Calculation(),
        FranceConsumption(),
      ],
      items: [
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
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calculate_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.flag_outlined),
          activeColorPrimary: MyColor.activeColor,
          inactiveColorPrimary: MyColor.inactiveColor,
        )
      ],
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 15),
      confineInSafeArea: false,
      navBarStyle: NavBarStyle.style12,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: MyColor.background,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3))
        ],
      ),
    );
  }
}
