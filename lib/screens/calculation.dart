import 'package:ecodot/components/buttonstyles.dart';
import 'package:ecodot/components/layout.dart';
import 'package:ecodot/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/inputfields.dart';

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

  //Couleurs entêtes listes déroulantes
  Color deviseTextColor = Colors.grey;
  Color deviceTypeTextColor = Colors.grey;
  Color durationUnitMicroTextColor = Colors.grey;
  Color durationUnitMacroTextColor = Colors.grey;

  //Controlleurs texte
  TextEditingController costController = TextEditingController();
  TextEditingController powerController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  //Récupération des types d'appareils
  List<String> deviceTypes = []; //TODO Alimenter cette liste avec l'appel API

  Future<http.Response> fetchDeviceTypes() {
    return http.get(Uri.parse(AppConstants().rootURI + ":" + AppConstants().rootPort + "/getalldevices"));
  }

  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: Column(children: [
      Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 25, bottom: 25),
          child: const Text("Calculer la consommation électrique",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Champ coût
            Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.only(top: 12),
                  child: new TextField(
                      controller: costController,
                      onTap: () {
                        deviseTextColor = Colors.grey;
                        durationUnitMacroTextColor = Colors.grey;
                        durationUnitMicroTextColor = Colors.grey;
                        deviceTypeTextColor = Colors.grey;

                        setState(() {});
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration:
                          new InputFieldDecorationGeneric1('Tarif du kWh')),
                )),
            Spacer(), //Espace entre les 2
            //Champ devise
            Expanded(
                flex: 7,
                child: Stack(children: [
                  Container(
                      padding: EdgeInsets.only(top: 12),
                      child: DropdownButtonFormField<String>(
                        value: devise,
                        alignment: AlignmentDirectional.center,
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
                        decoration: InputFieldDecorationGeneric1(""),
                        onTap: () {
                          deviseTextColor = Colors.lightGreenAccent;

                          durationUnitMacroTextColor = Colors.grey;
                          durationUnitMicroTextColor = Colors.grey;
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
                          padding: EdgeInsets.only(left: 5, right: 5),
                          //Ce padding crée un "blanc" pour couper la ligne en dessous
                          color: Colors.white,
                          child: Text("Unité",
                              style: TextStyle(
                                  color: deviseTextColor, fontSize: 12)))),
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
                  value: devise,
                  alignment: AlignmentDirectional.center,
                  items: [
                    //TODO Dropmenuitem pour chaque élément dans la liste devicenames
                  ],
                  decoration: InputFieldDecorationGeneric1(""),
                  onTap: () {
                    deviceTypeTextColor = Colors.lightGreenAccent;

                    durationUnitMacroTextColor = Colors.grey;
                    durationUnitMicroTextColor = Colors.grey;
                    deviseTextColor = Colors.grey;

                    setState(() {});
                  },
                  onChanged: (String? value) {
                    deviceType = value!;
                    //TODO Récup puissance via API Back ici et alimentation champ puissance
                  },
                ))),
        Positioned(
            left: 11,
            top: 6,
            child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                color: Colors.white,
                child: Text("Type d'appareil",
                    style:
                        TextStyle(color: deviceTypeTextColor, fontSize: 12)))),
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Champ durée
            Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.only(top: 12),
                  child: new TextField(
                      controller: durationController,
                      onTap: () {
                        deviseTextColor = Colors.grey;
                        durationUnitMacroTextColor = Colors.grey;
                        durationUnitMicroTextColor = Colors.grey;
                        deviceTypeTextColor = Colors.grey;

                        setState(() {});
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: new InputFieldDecorationGeneric1('Durée')),
                )),
            Spacer(), //Espace entre les 2
            //Champ unité micro
            Expanded(
                flex: 7,
                child: Stack(children: [
                  Container(
                      padding: EdgeInsets.only(top: 12),
                      child: DropdownButtonFormField<String>(
                        value: durationUnitMicro,
                        alignment: AlignmentDirectional.center,
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
                        decoration: InputFieldDecorationGeneric1(""),
                        onTap: () {
                          durationUnitMicroTextColor = Colors.lightGreenAccent;

                          durationUnitMacroTextColor = Colors.grey;
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
                          padding: EdgeInsets.only(left: 5, right: 5),
                          //Ce padding crée un "blanc" pour couper la ligne en dessous
                          color: Colors.white,
                          child: Text("Unité",
                              style: TextStyle(
                                  color: durationUnitMicroTextColor,
                                  fontSize: 12)))),
                ]))
          ]))),
      //5ème ligne
      FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      child: DropdownButtonFormField<String>(
                        value: durationUnitMacro,
                        alignment: AlignmentDirectional.center,
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
                        decoration: InputFieldDecorationGeneric1(""),
                        onTap: () {
                          durationUnitMacroTextColor = Colors.lightGreenAccent;

                          deviseTextColor = Colors.grey;
                          deviceTypeTextColor = Colors.grey;
                          durationUnitMicroTextColor = Colors.grey;

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
                          padding: EdgeInsets.only(left: 5, right: 5),
                          //Ce padding crée un "blanc" pour couper la ligne en dessous
                          color: Colors.white,
                          child: Text("Unité",
                              style: TextStyle(
                                  color: durationUnitMacroTextColor,
                                  fontSize: 12)))),
                ]))
          ]))),
      //Espace vide avant bouton
      Spacer(flex: 1),
      //Dernière ligne
      Expanded(
          flex: 1,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                decoration: ButtonDecoration1(),
                child: MaterialButton(
                    onPressed: () {
                      //TODO Envoi à l'API de calcul ici
                    },
                    child: Text("CALCUL", style: ButtonTextStyle1())),
              ))),
      //Espace vide pour barre du bas
      Spacer(flex: 3),
    ]));
  }
}
