import 'package:ecodot/model/my_consumption_model.dart';

class ApplicationStorage {
  late String token;
  late MyConsumptionModel consumption;

  ApplicationStorage() {}

  ApplicationStorage.fromJson(Map<String, dynamic> json)
      : token = json["token"];

  Map<String, dynamic> toJson() => {"token": token};

  setToken(String tokenParam) {
    token = tokenParam;
  }

  setConsumption(MyConsumptionModel consumptionParam) {
    consumption = consumptionParam;
  }
}
