import 'package:ecodot/components/bottom_navbar.dart';
import 'package:ecodot/components/sign_in/sign_in_dataholder.dart';
import 'package:ecodot/screens/calculation.dart';
import 'package:ecodot/screens/form_enedis_settings.dart';
import 'package:ecodot/screens/france_consumption.dart';
import 'package:ecodot/screens/guide.dart';
import 'package:ecodot/screens/home.dart';
import 'package:ecodot/screens/my_consumption.dart';
import 'package:ecodot/screens/public/login.dart';
import 'package:ecodot/screens/public/setup2.dart';
import 'package:ecodot/screens/public/setup1.dart';
import 'package:ecodot/screens/public/setup3.dart';
import 'package:ecodot/screens/public/sign_up.dart';
import 'package:ecodot/screens/ranking.dart';
import 'package:ecodot/screens/region_consumption.dart';
import "package:flutter/material.dart";

import 'components/application_dataholder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => SignInDataHolder(
          child: ApplicationDataHolder(
              child: MaterialApp(
        title: "Ecodot",
        debugShowCheckedModeBanner: false,
        home: const BottomNavbar(),
        initialRoute: "/login",
        routes: {
          "/home": (final context) => const Home(),
          "/my_consumption": (final context) => const MyConsumption(),
          "/ranking": (final context) => const Ranking(),
          "/france_consumption": (final context) => const FranceConsumption(),
          "/region_consumption": (final context) => const RegionConsumption(),
          "/calculation": (final context) => const Calculation(),
          "/login": (context) => const Login(),
          "/signup": (context) => const SignUp(),
          "/setupEnedis": (context) => const FormEnedisSettings(),
          "/guide": (context) => const Guide(),
          "/setup1": (final context) => const Setup1(),
          "/setup2": (final context) => const Setup2(),
          "/setup3": (final context) => const Setup3()
        },
      )));
}
