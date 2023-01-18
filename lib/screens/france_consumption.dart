import 'dart:convert';

import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/spline_area.dart';
import '../model/france_consumption.dart';

class FranceConsumption extends StatefulWidget {
  const FranceConsumption({super.key});

  @override
  State<FranceConsumption> createState() => _FranceConsumption();
}

class _FranceConsumption extends State<FranceConsumption> {
  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: SizedBox(
            child: Card(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: SplineArea(franceConsumption: getFranceConsumption())),
    )));
  }

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json"
      };

  Future<List<FranceConsumptionValue>> getFranceConsumption() async {
    http.Response response = await http.get(
        Uri.parse("http://localhost:8080/consommation/france"),
        headers: headers);
    List<FranceConsumptionValue> result = [];

    jsonDecode(response.body)["short_term"][0]["values"]
        .forEach((franceConsumption) {
      result.add(FranceConsumptionValue.fromJson(franceConsumption));
    });

    return result;
  }
}
