import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/constants.dart';

//Cette classe représente le retour de l'API back concernant les challenges
class Challenge{
  final String title;

  final String description;

  Challenge(this.title, this.description);


}

class Challenges{
  final List<Challenge> challengeList;

  Challenges({required this.challengeList});

  factory Challenges.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonlist = json['challengeList'];
    List<Challenge> outputlist = [];
    jsonlist.forEach((element) {
      Challenge challenge = new Challenge(element['title'], element['description']) ;
      outputlist.add(challenge);});

    return Challenges(challengeList: outputlist);
  }
}

//Fonction de récupération de n challenges au hasard
Future<Challenges> fetchChallenges(int n, List<Challenge> excludedChallenges) async {
  final body = {
    "numberChallenges": n,
    "excludedChallenges": excludedChallenges
  };


  Response apiResponse = await http.post(
      Uri.parse(AppConstants().rootURI +
          ":" +
          AppConstants().rootPort +
          "/nrandomchallenges"),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(body)
  );

  if (apiResponse.statusCode == 200) {
    Challenges challenges =
    Challenges.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return challenges;
  } else {
    return Challenges(challengeList: []);
  }
}