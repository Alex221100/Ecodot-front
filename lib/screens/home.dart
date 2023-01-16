import 'package:ecodot/screens/guide.dart';
import 'package:flutter/material.dart';

import '../components/layout.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MyLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 130,
              child: Card(
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                shadowColor: Colors.blueGrey,
                elevation: 10,
                child: Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 200,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Votre consommation",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            children: [
                              Image(image: AssetImage('electricity.png')),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Text("Electricité"),
                                      Text(
                                        "245 kW",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Card(
                margin: const EdgeInsets.only(right: 10, left: 10),
                color: Colors.white,
                shadowColor: Colors.blueGrey,
                elevation: 10,
                child: Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 200,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Challenges",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 400,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.white,
                      shadowColor: Colors.blueGrey,
                      elevation: 10,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image(
                                image: AssetImage('question.png'),
                                height: 60,
                                width: 60,
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Guide",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Text(
                                "Vous voulez réduire votre consommation énergétique et vous ne savez pas comment faire. Accéder à notre guide des bonnes pratiques que nous vous conseillons de mettre en place."),
                          ),
                          Container(
                            margin: const EdgeInsets.all(25),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff27AF56),
                                    Color(0xffC4FF00)
                                  ]),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                  return Guide();
                                }));
                              },
                              child: const Text(
                                'Voir',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 400,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.white,
                      shadowColor: Colors.blueGrey,
                      elevation: 10,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
