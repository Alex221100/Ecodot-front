import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(int i, {super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: 0,
      //on tap redirect to the page
      onTap: (index) => setState(() => index = index),

      dotIndicatorColor: Colors.black,
      // enableFloatingNavBar: true,
      // enablePaddingAnimation: true,
      items: [
        /// Calculator
        DotNavigationBarItem(
          icon: Icon(Icons.calculate_outlined),
          selectedColor: Colors.lightGreen,
        ),

        /// France
        DotNavigationBarItem(
          icon: Icon(Icons.flag_outlined),
          selectedColor: Colors.lightGreen,
        ),

        /// Home
        DotNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          selectedColor: Colors.lightGreen,
        ),

        /// Pie chart
        DotNavigationBarItem(
          icon: Icon(Icons.donut_small_outlined),
          selectedColor: Colors.lightGreen,
          //go to ma consommation page
        ),

        /// Leaderboard
        DotNavigationBarItem(
          icon: Icon(Icons.leaderboard_outlined),
          selectedColor: Colors.lightGreen,
        ),
      ],
    );
  }
}
