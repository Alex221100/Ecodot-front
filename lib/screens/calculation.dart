import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _Calculation();
}

class _Calculation extends State<Calculation> {
  @override
  Widget build(BuildContext context) {
    return const MyLayout(child: Text("Calculation"));
  }
}
