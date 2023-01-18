import 'dart:convert';

import 'package:ecodot/components/bar_chart.dart';
import 'package:ecodot/components/layout.dart';
import 'package:ecodot/screens/france_consumption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/spline_area.dart';
import '../model/france_consumption.dart';

class RegionConsumption extends StatefulWidget {
  const RegionConsumption({super.key});

  @override
  State<RegionConsumption> createState() => _RegionConsumption();
}

class _RegionConsumption extends State<RegionConsumption> {
  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: SizedBox(
            child: Card(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          // display consumption as text
          child: BarChart(regionConsumption: getRegionConsumption())),
    )));
  }

  static Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json"
      };

  static Future<Map<String, double>> getRegionConsumption() async {
    http.Response response = await http.get(
        Uri.parse("http://localhost:8080/consommation/region"),
        headers: headers);

    Map<String, double> result = {};

    jsonDecode(utf8.decode(response.bodyBytes))["records"].forEach((record) {
      dynamic fields = record["record"]["fields"];
      result[fields["region"]] = fields["SUM(total_energie_soutiree_wh)"];
    });

    return result;
  }
}
