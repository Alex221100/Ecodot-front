import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:ecodot/components/application_dataholder.dart';
import 'package:ecodot/components/layout.dart';
import 'package:ecodot/model/application_storage.dart';
import 'package:ecodot/screens/form_enedis_settings.dart';
import 'package:flutter/material.dart';
import 'package:ecodot/components/double_value_text_with_circle.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;

import '../model/my_consumption_model.dart';
import '../utils/constants.dart';

class MyConsumption extends StatefulWidget {
  const MyConsumption({super.key});

  @override
  State<MyConsumption> createState() => _MyConsumption();
}

class _MyConsumption extends State<MyConsumption> {
  titleComponent(int index) {
    switch (index) {
      case 0:
        return const Text("Consommation de la journée :",
            style: TextStyle(fontWeight: FontWeight.bold));
      case 1:
        return const Text("Consommation de la semaine :",
            style: TextStyle(fontWeight: FontWeight.bold));
      case 2:
        return const Text("Consommation du mois :",
            style: TextStyle(fontWeight: FontWeight.bold));
      case 3:
        return const Text("Consommation de l'année :",
            style: TextStyle(fontWeight: FontWeight.bold));
    }
  }

  doubleValueWithGoodUnit(int index, [MyConsumptionModel? mcm]) {
    double? day = mcm?.getDailyConsumption();
    double? week = mcm?.getWeeklyConsumption();
    double? month = mcm?.getMonthlyConsumption();
    double? year = mcm?.getYearlyConsumption();

    double daycons = day ?? 0;
    double weekcons = week ?? 0;
    double monthcons = month ?? 0;
    double yearcons = year ?? 0;

    switch (index) {
      case 0:
        return DoubleValueTextWithCircle(
          consumption: daycons,
          currency: '€',
          priceInCents: daycons * 0.1841,
          foregroundColor: Color(0xff56CA00),
          //maxValue: 12.5, set exemple value for demo
          maxValue: daycons * 1.2,
          unit: Unit.kWh,
        );
      case 1:
        return DoubleValueTextWithCircle(
          consumption: weekcons,
          currency: '€',
          priceInCents: weekcons * 0.1841,
          foregroundColor: Color(0xff56CA00),
          //maxValue: 87.5, set exemple value for demo
          maxValue: weekcons * 1.34,
          unit: Unit.kWh,
        );
      case 2:
        return DoubleValueTextWithCircle(
          consumption: monthcons,
          currency: '€',
          priceInCents: monthcons * 0.1841,
          foregroundColor: Color(0xff56CA00),
          //maxValue: 390, set exemple value for demo
          maxValue: monthcons * 1.111,
          unit: Unit.kWh,
        );
      case 3:
        return DoubleValueTextWithCircle(
          consumption: yearcons,
          currency: '€',
          priceInCents: yearcons * 0.1841,
          foregroundColor: Color(0xff56CA00),
          //maxValue: 4679, set exemple value for demo
          maxValue: yearcons * 1.34,
          unit: Unit.kWh,
        );

      default:
        return const DoubleValueTextWithCircle(
          consumption: 40.5,
          currency: '€',
          priceInCents: 40.5 * 27,
          foregroundColor: Color(0xff56CA00),
          maxValue: 100,
          unit: Unit.kWh,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final applicationDataHolder = ApplicationDataHolder.of(context);
    String token = applicationDataHolder.applicationStorage.token;
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String dateStr = date.toString().substring(0, 10);
    if (applicationDataHolder.applicationStorage.consumption.getDate() != dateStr){
       Future<MyConsumptionModel> mcm = getConsumptionsFromApi(token);
        mcm.then((value) => applicationDataHolder.applicationStorage.consumption = value);
    }else{
      MyConsumptionModel mcm = applicationDataHolder.applicationStorage.consumption;
    }
      
    return MyLayout(
        child: Column(children: [
      Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: const Text("Ma consommation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
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
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 272.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
              ),
              itemCount: 4,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Column(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 25, bottom: 25),
                      child: titleComponent(itemIndex)),
                  FutureBuilder<MyConsumptionModel>(
                      future: getConsumptions(token),
                      builder: (BuildContext context,
                          AsyncSnapshot<MyConsumptionModel> mcm) {
                        if (mcm.hasData) {
                          applicationDataHolder.applicationStorage
                              .setConsumption(mcm.data!);
                          return doubleValueWithGoodUnit(itemIndex, mcm.data);
                        }
                        return const CircularProgressIndicator();
                      })
                  //doubleValueWithGoodUnit(itemIndex, mcm),
                ],
              ),
            ),
          )),
      FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: EdgeInsets.only(top: 25),
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
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.help_outline,
                    size: 50, color: const Color(0xff56CA00)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: const LimitedBox(
                    maxWidth: 250,
                    maxHeight: 100,
                    child: Text(
                      'Vous souhaitez réduire votre consommation ? \nSuivez notre guide de bonnes pratiques sur les ressources énergétiques à la maison.',
                      textAlign: TextAlign.justify,
                    )),
              ),
            ],
          ),
        ),
      )
    ]));
  }

  Future<MyConsumptionModel> getConsumptions(String token) async {
    ApplicationDataHolder applicationDataHolder = ApplicationDataHolder.of(context);
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String dateStr = date.toString().substring(0, 10);
    MyConsumptionModel mcm = applicationDataHolder.applicationStorage.consumption;
    if (applicationDataHolder.applicationStorage.consumption.getDate() != dateStr){
      Future<MyConsumptionModel> mcm = getConsumptionsFromApi(token);
      mcm.then((value) => applicationDataHolder.applicationStorage.consumption = value);
    }
    return mcm;
  }

  Future<MyConsumptionModel> getConsumptionsFromApi(String token) async {
    http.Response response = await http.get(
        Uri.parse(AppConstants.rootURI +
            ":" +
            AppConstants.rootPort +
            "/myconsumption/all"),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
        });
    if (response.statusCode == 200) {
      MyConsumptionModel mcm =
          MyConsumptionModel.fromJson(jsonDecode(response.body));
      return mcm;
    } else if (response.statusCode == 204 || response.statusCode == 400) {
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
          FormEnedisSettings())
        );
        Flushbar(
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          message:
              "Veuillez vérifier vos données Enedis.",
          backgroundColor: Colors.red,
        )..show(context);

        return MyConsumptionModel();
      } else if (response.statusCode == 429) {
      throw Exception("We're working on it, please retry later(Like tomorrow)");
    }
    else{
      throw Exception("Failed to load user's consumptions");
    }
  }
}
