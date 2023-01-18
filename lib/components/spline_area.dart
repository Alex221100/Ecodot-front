/// Package import
import 'dart:convert';
import 'dart:math';

import 'package:ecodot/model/france_consumption.dart';
import 'package:ecodot/screens/france_consumption.dart';
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';
<<<<<<< HEAD
=======
import 'package:http/http.dart' as http;
import '../components/spline_area.dart';
import '../utils/constants.dart';
>>>>>>> 26c819da80960be6cfbb0b07b7e4fee9e4d729a2

class SplineArea extends StatefulWidget {
  final franceConsumption;
  final locality;

  SplineArea({Key? key, this.franceConsumption, this.locality = "France"})
      : super(key: key);

  @override
  _SplineAreaState createState() => _SplineAreaState();
}

/// State class of the spline area chart.
class _SplineAreaState extends State<SplineArea> {
  @override
  Widget build(BuildContext context) {
    return _buildSplineAreaChart();
  }

  /// Returns the cartesian spline are chart.
  SfCartesianChart _buildSplineAreaChart() {
    return SfCartesianChart(
      legend: Legend(isVisible: false, opacity: 0.7),
      title: ChartTitle(text: "Consommation en ${widget.locality} aujourd'hui"),
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(
          isVisible: false,
          maximumLabels: 1,
          minimum: 38000,
          labelFormat: '{value}kW',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getSplineAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ChartData> chartData = [];

  @override
  void initState() {
    widget.franceConsumption.then((result) {
      for (FranceConsumptionValue item in result) {
        setState(() {
          chartData.add(ChartData(
              DateTime(
                  int.parse(item.startDate.substring(0, 4)),
                  int.parse(item.startDate.substring(5, 7)),
                  int.parse(item.startDate.substring(8, 10)),
                  int.parse(item.startDate.substring(11, 13)),
                  int.parse(item.startDate.substring(14, 16))),
              item.value));
        });
      }
    });
    super.initState();
  }

  /// Returns the list of chart series
  /// which need to render on the spline area chart.
  List<ChartSeries<ChartData, DateTime>> _getSplineAreaSeries() {
    return <ChartSeries<ChartData, DateTime>>[
      SplineAreaSeries<ChartData, DateTime>(
        dataSource: chartData!,
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff27AF56), Color(0xffC4FF00)]),
        color: const Color(0xff27AF56),
        borderColor: const Color(0xff27AF56),
        borderWidth: 2,
        xValueMapper: (ChartData data, _) => data.y1,
        yValueMapper: (ChartData data, _) => data.y2,
      ),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

/// Private class for storing the spline area chart datapoints.
class ChartData {
  ChartData(this.y1, this.y2);
  final DateTime y1;
  final double y2;
}

Map<String, String> get headers => {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json"
    };

Future<List<FranceConsumptionValue>> getFranceConsumption() async {
  http.Response response = await http.get(
      Uri.parse(AppConstants().rootURI +
          ":" +
          AppConstants().rootPort +
          "/consommation/france"),
      headers: headers);
  List<FranceConsumptionValue> result = [];

  jsonDecode(response.body)["short_term"][0]["values"]
      .forEach((franceConsumption) {
    result.add(FranceConsumptionValue.fromJson(franceConsumption));
  });

  return result;
}
