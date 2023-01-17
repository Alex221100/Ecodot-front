import 'package:ecodot/model/application_storage.dart';
import 'package:flutter/material.dart';

class ApplicationDataHolder extends InheritedWidget {
  final ApplicationStorage applicationStorage = ApplicationStorage();

  ApplicationDataHolder({Key? key, required child})
      : super(key: key, child: child);

  static ApplicationDataHolder of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApplicationDataHolder>()!;
  }

  @override
  bool updateShouldNotify(ApplicationDataHolder oldWidget) =>
      oldWidget.applicationStorage != applicationStorage;

  setToken(String token) {
    applicationStorage.setToken(token);
  }
}
