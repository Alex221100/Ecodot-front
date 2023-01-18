import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

//Classes
class ScoreDTO {
  final String usermail;
  final String firstname;
  final String lastname;

  final int score;
  final int position;

  ScoreDTO(
      {required this.usermail,
      required this.firstname,
      required this.lastname,
      required this.score,
      required this.position});

  factory ScoreDTO.fromJson(Map<String, dynamic> json) {
    String usermail = json["usermail"];
    String firstname = json["firstname"];
    String lastname = json["lastname"];
    int score = json["score"];
    int position = json["position"];


    return ScoreDTO(
        usermail: usermail,
        firstname: firstname,
        lastname: lastname,
        score: score,
        position: position);
  }
}

class TopScoreScoreDTO {
  final String usermail;
  final int score;

  TopScoreScoreDTO(this.usermail, this.score);
}

class TopScoreUserDTO {
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  TopScoreUserDTO(this.email, this.password, this.firstname, this.lastname);
}

//Cette classe représente le retour de l'API back concernant le scoring
class TopScoreDTO {
  final List<TopScoreScoreDTO> scores;

  final List<TopScoreUserDTO> users;

  TopScoreDTO({required this.scores, required this.users});

  factory TopScoreDTO.fromJson(Map<String, dynamic> json) {
    List<dynamic> JSONScoreList = json['scores'];
    List<TopScoreScoreDTO> scoreList = [];
    for (var element in JSONScoreList) {
      TopScoreScoreDTO topScoreScoreDTO = TopScoreScoreDTO(
          element['usermail'], element['score']);
      scoreList.add(topScoreScoreDTO);
    }
    List<dynamic> JSONUserlist = json['users'];
    List<TopScoreUserDTO> userList = [];
    for (var element in JSONUserlist) {
      TopScoreUserDTO userScoreDTO = TopScoreUserDTO(
          element['email'], "", element['firstname'], element['lastname']);
      userList.add(userScoreDTO);
    }
    return TopScoreDTO(scores: scoreList, users: userList);
  }
}

//Fonction de récupération du classement
Future<TopScoreDTO> fetchTopScore(int n) async {
  final body = {"topNumber": n};

  Response apiResponse = await http.post(
      Uri.parse(AppConstants().rootURI +
          ":" +
          AppConstants().rootPort +
          "/score/top"),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(body));

  if (apiResponse.statusCode == 200) {
    TopScoreDTO topScoreDTO =
        TopScoreDTO.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return topScoreDTO;
  } else {
    return TopScoreDTO(scores: [], users: []);
  }
}

Future<ScoreDTO> fetchScore(String usermail) async {
  final body = {"usermail": usermail};

  Response apiResponse = await http.post(
      Uri.parse(
          AppConstants().rootURI + ":" + AppConstants().rootPort + "/score"),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(body));

  if (apiResponse.statusCode == 200) {
    ScoreDTO scoreDTO =
        ScoreDTO.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return scoreDTO;
  } else {
    return ScoreDTO(usermail: "", firstname: "", lastname: "", score: 0, position: 0);
  }
}

Future<ScoreDTO> fetchCurrentUserScore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? usermail = prefs.getString("currentusermail");
  print("mail:" + usermail.toString());
  final body = {"usermail": usermail};

  Response apiResponse = await http.post(
      Uri.parse(
          AppConstants().rootURI + ":" + AppConstants().rootPort + "/score"),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(body));

  if (apiResponse.statusCode == 200) {
    ScoreDTO scoreDTO =
        ScoreDTO.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return scoreDTO;
  } else {
    return ScoreDTO(usermail: "", firstname: "", lastname: "", score: 0, position: 0);
  }
}
