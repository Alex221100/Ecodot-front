import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

class FranceConsumption extends StatefulWidget {
  const FranceConsumption({super.key});

  @override
  State<FranceConsumption> createState() => _FranceConsumption();
}

class _FranceConsumption extends State<FranceConsumption> {
  @override
  Widget build(BuildContext context) {
    return const MyLayout(child: Text("FranceConsumption"));
  }
}
