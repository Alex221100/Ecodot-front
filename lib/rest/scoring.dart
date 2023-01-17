import 'dart:convert';
import 'dart:io';

import 'package:ecodot/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/constants.dart';


//Classes
class ScoreDTO{
  final String usermail;

  final String score;

  ScoreDTO(this.usermail, this.score);
}

class UserScoreDTO{
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  UserScoreDTO(this.email,this.password, this.firstname, this.lastname);
}

//Cette classe représente le retour de l'API back concernant le scoring
class TopScoreDTO{
  final List<ScoreDTO> scores;

  final List<UserScoreDTO> users;

  TopScoreDTO({required this.scores, required this.users});

  factory TopScoreDTO.fromJson(Map<String, dynamic> json) {
    List<dynamic> JSONScoreList = json['scores'];
    List<ScoreDTO> scoreList = [];
    for (var element in JSONScoreList) {
      ScoreDTO scoreDTO = ScoreDTO(element['usermail'], element['score'].toString());
      scoreList.add(scoreDTO);}
    List<dynamic> JSONUserlist = json['users'];
    List<UserScoreDTO> userList = [];
    for (var element in JSONUserlist) {
      UserScoreDTO userScoreDTO = UserScoreDTO(element['email'],"", element['firstname'], element['lastname']);
      userList.add(userScoreDTO);
    }



    return TopScoreDTO(scores: scoreList, users: userList);
  }
}

//Fonction de récupération du classement
Future<TopScoreDTO> fetchTopScore(int n) async {
  final body = {
    "topNumber": n
  };


  Response apiResponse = await http.post(
      Uri.parse(AppConstants().rootURI +
          ":" +
          AppConstants().rootPort +
          "/score/top"),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(body)
  );

  if (apiResponse.statusCode == 200) {
    TopScoreDTO topScoreDTO =
    TopScoreDTO.fromJson(jsonDecode(utf8.decode(apiResponse.bodyBytes)));
    return topScoreDTO;
  } else {
    return TopScoreDTO(scores: [], users: []);
  }
}