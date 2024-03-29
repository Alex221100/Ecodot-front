import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecodot/components/bar_chart.dart';
import 'package:ecodot/model/application_storage.dart';
import 'package:ecodot/screens/france_consumption.dart';
import 'package:ecodot/screens/guide.dart';
import 'package:ecodot/screens/my_consumption.dart';
import 'package:ecodot/screens/region_consumption.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/application_dataholder.dart';
import '../components/layout.dart';
import '../components/spline_area.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late List<Future> futuresList;
  late Future<SharedPreferences> futurePrefs;

  late SharedPreferences prefs;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    futurePrefs = SharedPreferences.getInstance();
    futuresList = [futurePrefs];
  }

  @override
  Widget build(BuildContext context) {
    final applicationDataHolder = ApplicationDataHolder.of(context);
    return MyLayout(
        child: FutureBuilder(
            future: Future.wait(futuresList),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (!isLoaded) {
                  prefs = snapshot.data![0];
                  futuresList.remove(futuresList);
                  isLoaded = true;
                }
                List<Container> challengeCards = [];
                int i = 0;
                if (prefs.getStringList("challengetitles") != null) {
                  for (String challengetitle
                      in prefs.getStringList("challengetitles")!) {
                    if (i < 2) {
                      challengeCards.add(
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3))
                                ]),
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    child: AutoSizeText(
                                  challengetitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 4,
                                )),
                                //Flexible(child: Text(challenge.description))
                              ],
                            )),
                      );
                    }
                    i++;
                  }
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        //Partie votre conso
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
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Votre consommation",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        const Image(
                                            image: AssetImage(
                                                'assets/electricity.png')),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Column(
                                            children: [
                                              const Text("Electricité"),
                                              FutureBuilder(
                                                future:
                                                    ApplicationDataHolder.of(
                                                            context)
                                                        .applicationStorage
                                                        .getToken(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return FutureBuilder(
                                                      future: MyConsumption
                                                          .getConsumptions(
                                                              snapshot.data!),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            "${snapshot.data!.dailyConsumption} Wh",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          );
                                                        } else {
                                                          return const Text(
                                                              "...");
                                                        }
                                                      },
                                                    );
                                                  } else {
                                                    return const Text("..");
                                                  }
                                                },
                                              ),
                                            ],
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
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 400,
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              color: Colors.white,
                              shadowColor: Colors.blueGrey,
                              elevation: 10,
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Image(
                                        image:
                                            AssetImage('assets/question.png'),
                                        height: 60,
                                        width: 60,
                                      )),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Guide",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: Text(
                                        "Vous voulez réduire votre consommation énergétique et vous ne savez pas comment faire. Accéder à notre guide des bonnes pratiques que nous vous conseillons de mettre en place."),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(25),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
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
                                        Navigator.push(context,
                                            MaterialPageRoute<void>(builder:
                                                (BuildContext context) {
                                          return const Guide();
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 400,
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              color: Colors.white,
                              shadowColor: Colors.blueGrey,
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SplineArea(
                                      franceConsumption: FranceConsumption
                                          .getFranceConsumption()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 370,
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            color: Colors.white,
                            shadowColor: Colors.blueGrey,
                            elevation: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BarChart(
                                    regionConsumption: RegionConsumption
                                        .getRegionConsumption()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else
                return const Center(child: CircularProgressIndicator());
            }));
  }
}
