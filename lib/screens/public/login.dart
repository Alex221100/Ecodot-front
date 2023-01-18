import 'dart:convert';
import 'package:ecodot/components/application_dataholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final applicationDataHolder = ApplicationDataHolder.of(context);
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
                  image: AssetImage('../assets/ecodot-with-name.png'),
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
                  child: Text("Suivez vos consommations énergétiques",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  onChanged: (value) => setState(() => email = value),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff27AF56)),
                    ),
                    labelText: 'Mail',
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => password = value),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xff27AF56)),
                  ),
                  labelText: 'Mot de passe',
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
                    http.Response req = await login(email, password);
                    if (req.statusCode == 200) {
                      applicationDataHolder.applicationStorage
                          .setToken(req.body);
                      Navigator.pushNamed(context, "/");
                      Flushbar(
                        duration: Duration(seconds: 3),
                        flushbarPosition: FlushbarPosition.TOP,
                        message: "Bienvenue sur Ecodot !",
                        backgroundColor: Colors.green,
                      )..show(context);
                    } else {
                      Flushbar(
                        duration: Duration(seconds: 3),
                        flushbarPosition: FlushbarPosition.TOP,
                        message:
                            "Votre email ou votre mot de passe est incorect.",
                        backgroundColor: Colors.red,
                      )..show(context);
                    }
                  },
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Vous avez oublié votre mot de passe ? ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Réintialisez-le.",
                  style: TextStyle(fontSize: 16),
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

  Future<http.Response> login(String email, String password) async {
    String body = jsonEncode({'email': email, 'password': password});

    http.Response response = await http.post(
        Uri.parse("http://localhost:8080/authentication/login"),
        headers: headers,
        body: body);

    return response;
  }
}
