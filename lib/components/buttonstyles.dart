//Ce fichier regroupe les classes de style générique pour les boutons

import 'package:flutter/material.dart';

//Decoration pour container du bouton (MaterialButton)
class ButtonDecoration1 extends BoxDecoration {
  ButtonDecoration1();

  final LinearGradient gradient = LinearGradient(
      colors: [Colors.green, Colors.lightGreenAccent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  final BorderRadiusGeometry borderRadius =
      BorderRadius.all(Radius.circular(5));
}

//Texte du bouton
class ButtonTextStyle1 extends TextStyle {
  ButtonTextStyle1();

  final Color color = Colors.white;
}
