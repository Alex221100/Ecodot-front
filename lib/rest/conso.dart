import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/constants.dart';

//Cette classe modélise l'aller retour de l'API back concernant la puissance d'un appareil
class ConsoResponse {
  final String deviceName;
  final num power;

  ConsoResponse({required this.deviceName, required this.power});

  factory ConsoResponse.fromJson(Map<String, dynamic> json) {
    return ConsoResponse(deviceName: json['devicename'], power: json['power']);
  }
}

//Fonction de récupération de la consommation d'un appareil
Future<ConsoResponse> fetchConsoResponse(String deviceName) async {
  final body = {
    "deviceName": deviceName,
  };

  Response apiResponse = await http.post(
    Uri.parse(AppConstants().rootURI +
        ":" +
        AppConstants().rootPort +
        "/consoreferential"),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(body)
  );

  if (apiResponse.statusCode == 200) {
    ConsoResponse consoResponse =
        ConsoResponse.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return consoResponse;
  } else {
    throw Exception(apiResponse.reasonPhrase);
  }
}
