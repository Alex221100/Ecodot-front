import 'package:flutter/material.dart';
import 'my_consumption.dart';
import 'home.dart';
import 'ranking.dart';
import 'france_consumption.dart';
import 'calculation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecodot',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Home(),
        "/home": (context) => const Home(),
        "/my_consumption": (context) => const MyConsumption(),
        "/ranking": (context) => const Ranking(),
        "/france_consumption": (context) => const FranceConsumption(),
        "/calculation": (context) => const Calculation(),
      },
    );
  }
}
