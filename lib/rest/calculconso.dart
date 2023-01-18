import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/constants.dart';

//Cette classe modélise le retour de l'API back concernant la puissance d'un appareil
class CalculConsoResponse {
  final num totalConsumptionPerHour;
  final num totalCostPerHour;
  final num totalConsumptionPerDay;
  final num totalCostPerDay;
  final num totalConsumptionPerMonth;
  final num totalCostPerMonth;
  final num totalConsumptionPerYear;
  final num totalCostPerYear;

  CalculConsoResponse(
      {required this.totalConsumptionPerHour,
      required this.totalCostPerHour,
      required this.totalConsumptionPerDay,
      required this.totalCostPerDay,
      required this.totalConsumptionPerMonth,
      required this.totalCostPerMonth,
      required this.totalConsumptionPerYear,
      required this.totalCostPerYear});

  factory CalculConsoResponse.fromJson(Map<String, dynamic> json) {
    return CalculConsoResponse(
        totalConsumptionPerHour: json['totalConsumptionPerHour'],
        totalCostPerHour: json['totalCostPerHour'],
        totalConsumptionPerDay: json['totalConsumptionPerDay'],
        totalCostPerDay: json['totalCostPerDay'],
        totalConsumptionPerMonth: json['totalConsumptionPerMonth'],
        totalCostPerMonth: json['totalCostPerMonth'],
        totalConsumptionPerYear: json['totalConsumptionPerYear'],
        totalCostPerYear: json['totalCostPerYear']);
  }
}

//Fonction de récupération du calcul de consommation
Future<CalculConsoResponse> fetchCalculConsoResponse(double cost, double power,
    int duration, String durationUnitMicro, String durationUnitMacro) async {
  final body = {
    "cost": cost,
    "power": power,
    "duration": duration,
    "durationUnitMicro": durationUnitMicro.toLowerCase()[0],
    "durationUnitMacro": durationUnitMacro.toLowerCase()[0]
  };

  Response apiResponse = await http.post(
      Uri.parse(
          AppConstants.rootURI + ":" + AppConstants.rootPort + "/calculconso"),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(body));

  print(json.encode(body));

  if (apiResponse.statusCode == 200) {
    CalculConsoResponse consoResponse = CalculConsoResponse.fromJson(
        jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return consoResponse;
  } else {
    print(apiResponse.statusCode.toString() +
        " " +
        apiResponse.reasonPhrase.toString());
    throw Exception(apiResponse.reasonPhrase);
  }
}
