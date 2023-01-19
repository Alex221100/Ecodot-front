import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:ecodot/components/application_dataholder.dart';
import 'package:ecodot/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/layout.dart';
import '../main.dart';
import '../utils/constants.dart';

class FormEnedisSettings extends StatefulWidget {
  const FormEnedisSettings({super.key});

  @override
  State<FormEnedisSettings> createState() => _FormEnedisSettings();
}

class _FormEnedisSettings extends State<FormEnedisSettings> {
  String enedisToken = "";
  String enedisPDL = "";

  @override
  Widget build(BuildContext context) {
    final applicationDataHolder = ApplicationDataHolder.of(context);
    String token = applicationDataHolder.applicationStorage.token!;

    return Scaffold(
      backgroundColor: const Color(0xffF4F5FA),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/ecodot-with-name.png'),
                  height: 160,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Votre point écologique",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Connectez votre compteur linky",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  onChanged: (value) => setState(() => enedisToken = value),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff27AF56)),
                    ),
                    labelText: 'Token Enedis',
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => enedisPDL = value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xff27AF56)),
                  ),
                  labelText: 'Point de livraison Enedis',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff27AF56), Color(0xffC4FF00)]),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () async {
                    http.Response req =
                        await saveTokenPDL(token, enedisToken, enedisPDL);
                    if (req.statusCode == 200) {
                      Navigator.pushNamed(context, "/");
                    } else {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => FormEnedisSettings()));
                      Flushbar(
                        duration: Duration(seconds: 3),
                        flushbarPosition: FlushbarPosition.TOP,
                        message:
                            "Une erreur est survenue, veuillez réessayer plus tard.",
                        backgroundColor: Colors.red,
                      )..show(context);
                    }
                  },
                  child: const Text(
                    'Sauvegarder',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json"
      };

  Future<http.Response> saveTokenPDL(
      String token, String enedisToken, String enedisPDL) async {
    String body = jsonEncode({
      'userToken': token,
      'enedisToken': enedisToken,
      'enedisPDL': enedisPDL
    });
    http.Response responseSetup = await http.post(
        Uri.parse(AppConstants.rootURI +
            ":" +
            AppConstants.rootPort +
            "/myconsumption/setupEnedis"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': "application/json",
        },
        body: body);
    if (responseSetup.statusCode == 200) {
      return responseSetup;
    } else {
      throw Exception("Failed to setup user's token");
    }
  }
}
