import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

import '../components/inputfields.dart';

//TODO Tarif du kWh persisté (cache/sharedpreferences)

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _Calculation();
}

class _Calculation extends State<Calculation> {
  String devise = "€";
  Color devisetextcolor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: Column(children: [
      Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 25, bottom: 25),
          child: const Text("Calculer la consommation électrique",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
            //Champ coût
            Container(
              padding: EdgeInsets.only(top: 12),
              width: 150,
              child: new TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: new InputFieldDecorationGeneric1('Tarif du kWh')),
            ),
            SizedBox(width: 15), //Espace entre les 2
                //Champ devise
            Stack(children: [
              Container(
                padding: EdgeInsets.only(top: 12),
                  width: 150,
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
                    onChanged: (String? value) {
                      devise = value!;
                    }
                    ,
                  ))
              ,Positioned(
                  left: 11,
                  top: 6,
                  child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      color: Colors.white,
                      child: Text("Unité",
                          style: TextStyle(color: devisetextcolor, fontSize: 12)))),
            ])
          ]))
    ]));
  }
}
