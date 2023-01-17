import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

class Setup1 extends StatefulWidget {
  const Setup1({super.key});

  @override
  State<Setup1> createState() => _Setup1();
}

class _Setup1 extends State<Setup1> {
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
                image: AssetImage('../assets/ecodot-with-name.png'),
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
                        "Suivre votre consommation",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Suivez votre consommation électrique en temps réel en vous connectant directement avec votre compte Enedis",
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
                          image: AssetImage('../assets/setup1.png'),
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
                        Navigator.pushNamed(context, "/setup2");
                      }),
                      child: const Text(
                        'Continuer',
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
