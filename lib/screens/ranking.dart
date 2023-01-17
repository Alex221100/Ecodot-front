import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

import '../rest/challenge.dart';
import '../rest/scoring.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _Ranking();
}

class _Ranking extends State<Ranking> {

  late TopScoreDTO topScore;
  late Challenges challenges;

  late List<Future> futuresList;
  late Future<TopScoreDTO> futureTopScore;
  late Future<Challenges> futureChallenges;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    futureTopScore = fetchTopScore(10);
    futureChallenges = fetchChallenges(3, []);
    futuresList = [futureTopScore, futureChallenges];
  }

  @override
  Widget build(BuildContext context) {
    return MyLayout(
        child: FutureBuilder(
            future: Future.wait(futuresList),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (!isLoaded) {
                  topScore = snapshot.data![0];
                  challenges = snapshot.data![1];
                  futuresList.remove(futureTopScore);
                  futuresList.remove(futureChallenges);
                  //Pour optimiser les appels à la bdd, n'appelle plus à chaque build
                  isLoaded = true;
                }
                List<DataRow> rankingRowsList = [];
                int i = 0;
                for (UserScoreDTO user in topScore.users) {
                  ScoreDTO score = topScore.scores[i];
                  rankingRowsList.add(new DataRow(cells: [
                    DataCell(Text((i + 1).toString())),
                    DataCell(Text(user.firstname + " " + user.lastname)),
                    DataCell(Text(score.score))
                  ]));
                  i++;
                }

                List<Container> challengeCards = [];
                for (Challenge challenge in challenges.challengeList) {
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
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: AutoSizeText(
                              challenge.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 4,
                            )),
                            //Flexible(child: Text(challenge.description))
                          ],
                        )),
                  );
                }

                return Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 15),
                    height: 1000,
                    child: FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.9,
                        child: Column(
                          children: [
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
                                child: Column(children: [
                                  Container(
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.only(
                                          top: 25,
                                          bottom: 25,
                                          left: 20,
                                          right: 20),
                                      child: AutoSizeText("Classement",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                  FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: Container(
                                          child: DataTable(
                                        columns: [
                                          DataColumn(label: Text("Position")),
                                          DataColumn(label: Text("Nom")),
                                          DataColumn(label: Text("Score")),
                                        ],
                                        rows: rankingRowsList,
                                      )))
                                ])),
                            Container(
                              padding: EdgeInsets.all(7),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
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
                                child: Column(children: [
                                  Container(
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          left: 20,
                                          right: 20),
                                      child: AutoSizeText("Challenges",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: challengeCards)
                                ]))
                          ],
                        )));
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
