import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';
import 'package:ecodot/components/double_value_text_with_circle.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyConsumption extends StatefulWidget {
  const MyConsumption({super.key});

  @override
  State<MyConsumption> createState() => _MyConsumption();
}

class _MyConsumption extends State<MyConsumption> {
  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: Column(children: [
      Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: const Text("Ma consommation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ]),
            child: Column(children: [
              Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: const Text("Consommation moyenne",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const DoubleValueTextWithCircle(
                consumption: 4.5,
                currency: '€',
                priceInCents: 4.5 * 27,
                foregroundColor: const Color(0xff56CA00),
                maxValue: 6,
                unit: Unit.kWh,
              ),
            ]),
          )),
      Spacer(),
      FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ]),
            child: Column(children: [
              Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: const Text("Consommation moyenne",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const DoubleValueTextWithCircle(
                consumption: 4.5,
                currency: '€',
                priceInCents: 4.5 * 27,
                foregroundColor: const Color(0xff56CA00),
                maxValue: 6,
                unit: Unit.kWh,
              ),
            ]),
          )),
    ]));
  }
}
