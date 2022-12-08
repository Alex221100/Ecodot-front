import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, this.index});
  final index;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = widget.index;

  void _handleIndexChanged(int i) {
    setState(() {
      _currentIndex = i;
      Navigator.pushNamed(context, '/my_consumption');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: _currentIndex,
      onTap: _handleIndexChanged,
      dotIndicatorColor: Colors.black,
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

enum routes { home, my_consumption }
