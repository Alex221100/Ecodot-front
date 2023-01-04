import 'package:flutter/material.dart';
import 'package:ecodot/components/top_menu.dart';
import '../inputfields.dart';

class FormHouse extends StatefulWidget {
  const FormHouse({super.key});

  @override
  State<FormHouse> createState() => _FormHouse();
}

class _FormHouse extends State<FormHouse> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Votre maison",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration: new InputFieldDecorationGeneric1(
                        'Nombre de personne dans le foyer'))),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration:
                        new InputFieldDecorationGeneric1('Code postal'))),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration: new InputFieldDecorationGeneric1('Ville'))),
          ],
        ),
      ),
    );
  }
}
