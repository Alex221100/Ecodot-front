import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

class MyConsumption extends StatefulWidget {
  const MyConsumption({super.key});

  @override
  State<MyConsumption> createState() => _MyConsumption();
}

class _MyConsumption extends State<MyConsumption> {
  @override
  Widget build(BuildContext context) {
    return const MyLayout(child: Text("MyConsumption"));
  }
}
