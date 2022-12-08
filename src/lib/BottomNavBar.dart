import 'package:ecodot/MaConsommation.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'Calculatrice.dart';
import 'France.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(int i, {super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _current_index = 2;
  @override
  Widget build(BuildContext context) {
    Widget _selectedTab;
    return DotNavigationBar(
      currentIndex: _current_index,
      //on tap redirect to the page
      onTap: (index) => {
        setState(() => _current_index = index),
        _selectedTab = _allTabs[index]!,
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => _selectedTab),
        )
      },

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

Map<int, Widget> _allTabs = {
  0: Calculatrice(title: 'calculette'),
  1: France(
    title: 'France',
  ),
  2: MaConsommation(title: 'Accueil'),
  3: MaConsommation(title: 'Ma consommation'),
  4: MaConsommation(title: 'Classement'),
};
