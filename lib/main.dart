import 'package:ecodot/components/bottom_navbar.dart';
import 'package:ecodot/screens/calculation.dart';
import 'package:ecodot/screens/france_consumption.dart';
import 'package:ecodot/screens/home.dart';
import 'package:ecodot/screens/my_consumption.dart';
import 'package:ecodot/screens/ranking.dart';
import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        title: "Ecodot",
        debugShowCheckedModeBanner: false,
        home: const BottomNavbar(),
        initialRoute: "/",
        routes: {
          "/home": (final context) => const Home(),
          "/my_consumption": (final context) => const MyConsumption(),
          "/ranking": (final context) => const Ranking(),
          "/france_consumption": (final context) => const FranceConsumption(),
          "/calculation": (final context) => const Calculation(),
        },
      );
}
