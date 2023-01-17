import 'dart:convert';

import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/good_practise.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _Guide();
}

class _Guide extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return MyLayout(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder<List<GoodPractise>>(
                future: getAllGoodPractises(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<GoodPractise>> snapshot) {
                  List<Widget> list = [];
                  if (snapshot.hasData) {
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      list.add(SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          color: Colors.white,
                          shadowColor: Colors.blueGrey,
                          elevation: 10,
                          child: GridView.extent(
                            primary: false,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 2,
                            physics: NeverScrollableScrollPhysics(),
                            maxCrossAxisExtent: 200.0,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data![i].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      Text(snapshot.data![i].description,
                                          style: TextStyle(fontSize: 10))
                                    ],
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.memory(
                                      base64Decode(snapshot.data![i].image))),
                            ],
                          ),
                        ),
                      ));
                    }

                    return Column(children: list);
                  }
                  return CircularProgressIndicator();
                },
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

  Future<List<GoodPractise>> getAllGoodPractises() async {
    http.Response response = await http
        .get(Uri.parse("http://localhost:8080/guide"), headers: headers);

    List<GoodPractise> goodPractises = [];

    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((goodPractiseJson) {
        goodPractises.add(GoodPractise.fromJson(goodPractiseJson));
      });

      return goodPractises;
    } else {
      throw Exception("Failed to load all good practises");
    }
  }
}
