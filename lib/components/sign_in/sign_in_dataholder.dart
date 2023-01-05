import 'package:flutter/material.dart';
import '../../model/user.dart';

class SignInDataHolder extends InheritedWidget {
  final User user = User();

  SignInDataHolder({Key? key, required child}) : super(key: key, child: child);

  static SignInDataHolder of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SignInDataHolder>()!;
  }

  @override
  bool updateShouldNotify(SignInDataHolder oldWidget) => oldWidget.user != user;

  setUserLastname(String lastname) {
    user.setLastname(lastname);
  }

  setUserFirstname(String firstname) {
    user.setLastname(firstname);
  }

  setUserEmail(String email) {
    user.setEmail(email);
  }

  setUserPassword(String password) {
    user.setPassword(password);
  }

  setUserNbPersonHouse(int nbPersonHouse) {
    user.setNbPersonHouse(nbPersonHouse);
  }

  setUserCityCode(String cityCode) {
    user.setCityCode(cityCode);
  }

  setUserCity(String city) {
    user.setCity(city);
  }
}
