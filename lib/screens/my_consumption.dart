import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';
import 'package:ecodot/components/double_value_text_with_circle.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyConsumption extends StatefulWidget {
  const MyConsumption({super.key});

  @override
  State<MyConsumption> createState() => _MyConsumption();
}

class _MyConsumption extends State<MyConsumption> {
  titleComponent(int index) {
    switch (index) {
      case 1:
        return const Text("Consommation de la journée :",
            style: TextStyle(fontWeight: FontWeight.bold));
      case 2:
        return const Text("Consommation de la semaine :",
            style: TextStyle(fontWeight: FontWeight.bold));
      case 3:
        return const Text("Consommation du mois :",
            style: TextStyle(fontWeight: FontWeight.bold));
      case 4:
        return const Text("Consommation de l'année :",
            style: TextStyle(fontWeight: FontWeight.bold));
    }
  }

  doubleValueWithGoodUnit(int index) {
    switch (index) {
      case 1:
        return const DoubleValueTextWithCircle(
          consumption: 40.5,
          currency: '€',
          priceInCents: 40.5 * 27,
          foregroundColor: Color(0xff56CA00),
          maxValue: 100,
          unit: Unit.kWh,
        );
      case 2:
        return const DoubleValueTextWithCircle(
          consumption: 40.5,
          currency: '€',
          priceInCents: 40.5 * 27,
          foregroundColor: Color(0xff56CA00),
          maxValue: 100,
          unit: Unit.kWh,
        );
      case 3:
        return const DoubleValueTextWithCircle(
          consumption: 40.5,
          currency: '€',
          priceInCents: 40.5 * 27,
          foregroundColor: Color(0xff56CA00),
          maxValue: 100,
          unit: Unit.kWh,
        );
      case 4:
        return const DoubleValueTextWithCircle(
          consumption: 40.5,
          currency: '€',
          priceInCents: 40.5 * 27,
          foregroundColor: Color(0xff56CA00),
          maxValue: 100,
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
                  doubleValueWithGoodUnit(itemIndex),
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
                    maxWidth: 280,
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
}
