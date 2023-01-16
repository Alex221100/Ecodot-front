//Ce fichier regroupe les classes de style générique pour les champs d'entrée

import 'package:flutter/material.dart';

//Décoration champ texte par défault
class InputFieldDecorationGeneric1 extends InputDecoration {
  InputFieldDecorationGeneric1(this.hintText);

  String hintText;
  final InputBorder enabledBorder = new OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(10)));
  final InputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.lightGreenAccent),
      borderRadius: BorderRadius.all(Radius.circular(10)));
}
