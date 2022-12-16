import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/constants.dart';

//Cette classe représente le retour de l'API back concernant les types d'appareils dispos en base
class DeviceTypes {
  final List<String> deviceNameArrayList;

  DeviceTypes({required this.deviceNameArrayList});


  factory DeviceTypes.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonlist = json['deviceNameArrayList'];
    List<String> outputlist = [];
    jsonlist.forEach((element) { outputlist.add(element.toString()); });

    return DeviceTypes(deviceNameArrayList: outputlist);
  }

}

//Fonction de récupération des types d'appareils
Future<DeviceTypes> fetchDeviceTypes() async {
  Response apiResponse = await http.get(Uri.parse(AppConstants().rootURI +
      ":" +
      AppConstants().rootPort +
      "/getalldevices"));

  if (apiResponse.statusCode == 200) {
    DeviceTypes deviceTypes =
    DeviceTypes.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return deviceTypes;
  } else {
    return DeviceTypes(deviceNameArrayList: []);
  }
}