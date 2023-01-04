import 'package:flutter/material.dart';
import 'package:ecodot/components/top_menu.dart';
import '../inputfields.dart';

class FormInformation extends StatefulWidget {
  const FormInformation({super.key});

  @override
  State<FormInformation> createState() => _FormInformation();
}

class _FormInformation extends State<FormInformation> {
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
                  "Vos informations",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration: new InputFieldDecorationGeneric1('Nom'))),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration: new InputFieldDecorationGeneric1('Prénom'))),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration: new InputFieldDecorationGeneric1('Mail'))),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration:
                        new InputFieldDecorationGeneric1('Mot de passe'))),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                    onChanged: (value) => setState(() => name = value),
                    decoration: new InputFieldDecorationGeneric1(
                        'Confirmation de mot de passe'))),
          ],
        ),
      ),
    );
  }
}
