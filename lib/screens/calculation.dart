import 'dart:convert';

import 'package:ecodot/components/buttonstyles.dart';
import 'package:ecodot/components/layout.dart';
import 'package:ecodot/rest/calculconso.dart';
import 'package:ecodot/rest/devicetypes.dart';
import 'package:flutter/material.dart';

import '../components/inputfields.dart';
import '../rest/conso.dart';

//TODO Tarif du kWh persisté (cache/sharedpreferences)

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _Calculation();
}

class _Calculation extends State<Calculation> {
  //Variables
  String devise = "€";
  String deviceType = "";
  String durationUnitMicro = "heure(s)";
  String durationUnitMacro = "jour";

  bool isLoaded = false;
  bool hasReceivedResponse = false;

  CalculConsoResponse calculConsoResponse = CalculConsoResponse(
      totalConsumptionPerHour: 0,
      totalCostPerHour: 0,
      totalConsumptionPerDay: 0,
      totalCostPerDay: 0,
      totalConsumptionPerMonth: 0,
      totalCostPerMonth: 0,
      totalConsumptionPerYear: 0,
      totalCostPerYear: 0);

  //Couleurs entêtes listes déroulantes
  Color deviseTextColor = Colors.grey;
  Color deviceTypeTextColor = Colors.grey;
  Color durationUnitMicroTextColor = Colors.grey;
  Color durationUnitMacroTextColor = Colors.grey;

  //Controlleurs texte
  TextEditingController costController = TextEditingController();
  TextEditingController powerController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  List<String> deviceTypes = [];
  late Future<DeviceTypes> futureDeviceTypes;
  late Future<ConsoResponse> futureConsoResponse;
  late Future<CalculConsoResponse> futureCalculConsoResponse;
  late List<Future> futuresList;

  @override
  void initState() {
    super.initState();

    futureDeviceTypes = fetchDeviceTypes();
    futureConsoResponse = futureDeviceTypes
        .then((value) => fetchConsoResponse(value.deviceNameArrayList.first));
    futuresList = [futureDeviceTypes, futureConsoResponse];
  }

  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: FutureBuilder(
            future: Future.wait(futuresList),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                deviceTypes = snapshot.data![0].deviceNameArrayList;
                if (!isLoaded) {
                  ConsoResponse snapshotConsoResponse = snapshot.data![1];
                  powerController.text = snapshotConsoResponse.power.toString();
                  futuresList.remove(
                      futureConsoResponse); //Pour optimiser les appels à la bdd, n'appelle plus ConsoReferential à chaque build
                  isLoaded = true;
                }
                return Container(
                    height: 700,
                    child: Column(children: [
                      Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: const Text(
                              "Calculer la consommation électrique",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                //Champ coût
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 12),
                                      child: new TextField(
                                          controller: costController,
                                          onTap: () {
                                            deviseTextColor = Colors.grey;
                                            durationUnitMacroTextColor =
                                                Colors.grey;
                                            durationUnitMicroTextColor =
                                                Colors.grey;
                                            deviceTypeTextColor = Colors.grey;

                                            setState(() {});
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              new InputFieldDecorationGeneric1(
                                                  'Tarif du kWh')),
                                    )),
                                Spacer(), //Espace entre les 2
                                //Champ devise
                                Expanded(
                                    flex: 7,
                                    child: Stack(children: [
                                      Container(
                                          padding: EdgeInsets.only(top: 12),
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: devise,
                                            alignment:
                                                AlignmentDirectional.center,
                                            items: [
                                              DropdownMenuItem(
                                                value: "€",
                                                child: Text("€"),
                                              ),
                                              DropdownMenuItem(
                                                value: "\$",
                                                child: Text("\$"),
                                              )
                                            ],
                                            decoration:
                                                InputFieldDecorationGeneric1(
                                                    ""),
                                            onTap: () {
                                              deviseTextColor =
                                                  Colors.lightGreenAccent;

                                              durationUnitMacroTextColor =
                                                  Colors.grey;
                                              durationUnitMicroTextColor =
                                                  Colors.grey;
                                              deviceTypeTextColor = Colors.grey;

                                              setState(() {});
                                            },
                                            onChanged: (String? value) {
                                              devise = value!;
                                            },
                                          )),
                                      Positioned(
                                          left: 11,
                                          top: 6,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              //Ce padding crée un "blanc" pour couper la ligne en dessous
                                              color: Colors.white,
                                              child: Text("Unité",
                                                  style: TextStyle(
                                                      color: deviseTextColor,
                                                      fontSize: 12)))),
                                    ]))
                              ]))),
                      Container(
                          //2nde ligne
                          child:
                              //Champ type appareil
                              Stack(children: [
                        FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                                padding: EdgeInsets.only(top: 12),
                                child: DropdownButtonFormField<String>(
                                  value: deviceTypes.first,
                                  alignment: AlignmentDirectional.center,
                                  items: deviceTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  decoration: InputFieldDecorationGeneric1(""),
                                  onTap: () {
                                    deviceTypeTextColor =
                                        Colors.lightGreenAccent;

                                    durationUnitMacroTextColor = Colors.grey;
                                    durationUnitMicroTextColor = Colors.grey;
                                    deviseTextColor = Colors.grey;

                                    setState(() {});
                                  },
                                  onChanged: (String? value) async {
                                    deviceType = value!;
                                    ConsoResponse consoResponse =
                                        await fetchConsoResponse(deviceType);
                                    powerController.text =
                                        consoResponse.power.toString();
                                  },
                                ))),
                        Positioned(
                            left: 11,
                            top: 6,
                            child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                color: Colors.white,
                                child: Text("Type d'appareil",
                                    style: TextStyle(
                                        color: deviceTypeTextColor,
                                        fontSize: 12)))),
                      ])),
                      //3ème ligne
                      FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                            padding: EdgeInsets.only(top: 12),
                            child: new TextField(
                                controller: powerController,
                                onTap: () {
                                  deviseTextColor = Colors.grey;
                                  durationUnitMacroTextColor = Colors.grey;
                                  durationUnitMicroTextColor = Colors.grey;
                                  deviceTypeTextColor = Colors.grey;

                                  setState(() {});
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: new InputFieldDecorationGeneric1(
                                    'Puissance de l\'appareil')),
                          )),
                      //4ème ligne
                      FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                //Champ durée
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 12),
                                      child: new TextField(
                                          controller: durationController,
                                          onTap: () {
                                            deviseTextColor = Colors.grey;
                                            durationUnitMacroTextColor =
                                                Colors.grey;
                                            durationUnitMicroTextColor =
                                                Colors.grey;
                                            deviceTypeTextColor = Colors.grey;

                                            setState(() {});
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              new InputFieldDecorationGeneric1(
                                                  'Durée')),
                                    )),
                                Spacer(), //Espace entre les 2
                                //Champ unité micro
                                Expanded(
                                    flex: 7,
                                    child: Stack(children: [
                                      Container(
                                          padding: EdgeInsets.only(top: 12),
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: durationUnitMicro,
                                            alignment:
                                                AlignmentDirectional.center,
                                            items: [
                                              DropdownMenuItem(
                                                value: "heure(s)",
                                                child: Text("heure(s)"),
                                              ),
                                              DropdownMenuItem(
                                                value: "minute(s)",
                                                child: Text("minute(s)"),
                                              ),
                                              DropdownMenuItem(
                                                value: "seconde(s)",
                                                child: Text("seconde(s)"),
                                              )
                                            ],
                                            decoration:
                                                InputFieldDecorationGeneric1(
                                                    ""),
                                            onTap: () {
                                              durationUnitMicroTextColor =
                                                  Colors.lightGreenAccent;

                                              durationUnitMacroTextColor =
                                                  Colors.grey;
                                              deviseTextColor = Colors.grey;
                                              deviceTypeTextColor = Colors.grey;

                                              setState(() {});
                                            },
                                            onChanged: (String? value) {
                                              durationUnitMicro = value!;
                                            },
                                          )),
                                      Positioned(
                                          left: 11,
                                          top: 6,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              //Ce padding crée un "blanc" pour couper la ligne en dessous
                                              color: Colors.white,
                                              child: Text("Unité",
                                                  style: TextStyle(
                                                      color:
                                                          durationUnitMicroTextColor,
                                                      fontSize: 12)))),
                                    ]))
                              ]))),
                      //5ème ligne
                      FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 12),
                                      child: new Text(
                                        "Par",
                                        textAlign: TextAlign.right,
                                      ),
                                    )),
                                Spacer(), //Espace entre les 2
                                //Champ unité durée macro
                                Expanded(
                                    flex: 7,
                                    child: Stack(children: [
                                      Container(
                                          padding: EdgeInsets.only(top: 12),
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: durationUnitMacro,
                                            alignment:
                                                AlignmentDirectional.center,
                                            items: [
                                              DropdownMenuItem(
                                                value: "jour",
                                                child: Text("jour"),
                                              ),
                                              DropdownMenuItem(
                                                value: "mois",
                                                child: Text("mois"),
                                              ),
                                              DropdownMenuItem(
                                                value: "an",
                                                child: Text("an"),
                                              )
                                            ],
                                            decoration:
                                                InputFieldDecorationGeneric1(
                                                    ""),
                                            onTap: () {
                                              durationUnitMacroTextColor =
                                                  Colors.lightGreenAccent;

                                              deviseTextColor = Colors.grey;
                                              deviceTypeTextColor = Colors.grey;
                                              durationUnitMicroTextColor =
                                                  Colors.grey;

                                              setState(() {});
                                            },
                                            onChanged: (String? value) {
                                              durationUnitMacro = value!;
                                            },
                                          )),
                                      Positioned(
                                          left: 11,
                                          top: 6,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              //Ce padding crée un "blanc" pour couper la ligne en dessous
                                              color: Colors.white,
                                              child: Text("Unité",
                                                  style: TextStyle(
                                                      color:
                                                          durationUnitMacroTextColor,
                                                      fontSize: 12)))),
                                    ]))
                              ]))),
                      //Dernière ligne (bouton)
                      Container(
                          padding: EdgeInsets.only(top:20),
                          child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                            decoration: ButtonDecoration1(),
                            child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    //Vérifs si OK
                                    if (costController.text != "" &&
                                        durationController.text != "" &&
                                        powerController.text != "") {
                                      futureCalculConsoResponse =
                                          fetchCalculConsoResponse(
                                                  double.parse(
                                                      costController.text),
                                                  double.parse(
                                                      powerController.text),
                                                  int.parse(
                                                      durationController.text),
                                                  durationUnitMicro,
                                                  durationUnitMacro)
                                              .then((value) =>
                                                  calculConsoResponse = value)
                                              .whenComplete(() =>
                                                  hasReceivedResponse = true);
                                    }
                                  });
                                },
                                child:
                                    Text("CALCUL", style: ButtonTextStyle1())),
                          ))),
                      if (hasReceivedResponse)
                        Container(padding : EdgeInsets.only(top: 20),
                            child:
                        FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Container(
                                //Zone résultats
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.circle,
                                            color: Colors.green, size: 15)),
                                    Text(
                                      "Consommation totale horaire",
                                      textScaleFactor: 0.9,
                                    ),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalConsumptionPerHour
                                                .toStringAsFixed(4))
                                            .toString() +
                                        " kW"),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalCostPerHour
                                                .toStringAsFixed(2))
                                            .toString() +
                                        devise),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.circle,
                                            color: Colors.green, size: 15)),
                                    Text(
                                      "Consommation totale journalière",
                                      textScaleFactor: 0.9,
                                    ),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalConsumptionPerDay
                                                .toStringAsFixed(4))
                                            .toString() +
                                        " kW"),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalCostPerDay
                                                .toStringAsFixed(2))
                                            .toString() +
                                        devise),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.circle,
                                            color: Colors.green, size: 15)),
                                    Text(
                                      "Consommation totale mensuelle",
                                      textScaleFactor: 0.9,
                                    ),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalConsumptionPerMonth
                                                .toStringAsFixed(2))
                                            .toString() +
                                        " kW"),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalCostPerMonth
                                                .toStringAsFixed(2))
                                            .toString() +
                                        devise),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.circle,
                                            color: Colors.green, size: 15)),
                                    Text(
                                      "Consommation totale annuelle",
                                      textScaleFactor: 0.9,
                                    ),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalConsumptionPerYear
                                                .toStringAsFixed(2))
                                            .toString() +
                                        " kW"),
                                    Spacer(),
                                    Text(double.parse(calculConsoResponse
                                                .totalCostPerYear
                                                .toStringAsFixed(2))
                                            .toString() +
                                        devise),
                                  ],
                                ),
                              ],
                            )))),
                    ]));
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
