import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  final Future<Map<String, double>> regionConsumption;

  const BarChart({Key? key, required this.regionConsumption}) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  final List<ChartData> chartData = [];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'Consommation par région en TWh'),
      series: _getBarSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      //Show numeric values on bars, but not on the axis
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
    );
  }

  @override
  void initState() {
    widget.regionConsumption.then((result) {
      const int TWh = 1000000000000;
      for (var item in result.entries) {
        setState(() {
          chartData.add(ChartData(item.key, (item.value / TWh).round()));
        });
      }
    });
  }

  List<BarSeries<ChartData, String>> _getBarSeries() {
    return <BarSeries<ChartData, String>>[
      BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          // Gradient from 0xff27AF56 to 0xffC4FF00
          gradient: const LinearGradient(
              colors: [Color(0xff27AF56), Color(0xffC4FF00)],
              stops: [0.25, 0.75]))
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
