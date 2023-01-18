import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

class Setup3 extends StatefulWidget {
  const Setup3({super.key});

  @override
  State<Setup3> createState() => _Setup3();
}

class _Setup3 extends State<Setup3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5FA),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/ecodot-with-name.png'),
                height: 140,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  shadowColor: Colors.blueGrey,
                  elevation: 10,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Accéder à la consommation française",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Accéder à la consommation énergétique de la France et de votre région.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('assets/Setup3.png'),
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff27AF56),
                        shadowColor: Colors.transparent,
                        side: const BorderSide(
                            width: 1, color: Color(0xff8A8D93)),
                      ),
                      onPressed: (() {
                        Navigator.pushNamed(context, "/setup2");
                      }),
                      child: const Text(
                        'Retour',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff27AF56),
                          shadowColor: Colors.transparent,
                          side: const BorderSide(
                              width: 1, color: Color(0xff8A8D93)),
                        ),
                        onPressed: (() {
                          Navigator.pushNamed(context, "/login");
                        }),
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff27AF56),
                        shadowColor: Colors.transparent,
                        side: const BorderSide(
                            width: 1, color: Color(0xff8A8D93)),
                      ),
                      onPressed: (() {
                        Navigator.pushNamed(context, "/signup");
                      }),
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
