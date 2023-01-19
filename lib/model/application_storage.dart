import 'package:ecodot/model/my_consumption_model.dart';

class ApplicationStorage {
  String? token;
  MyConsumptionModel? consumption;

  ApplicationStorage();

  ApplicationStorage.fromJson(Map<String, dynamic> json)
      : token = json["token"];

  Map<String, dynamic> toJson() => {"token": token};

  setToken(String tokenParam) {
    token = tokenParam;
  }

  setConsumption(MyConsumptionModel consumptionParam) {
    consumption = consumptionParam;
  }

  Future<String> getToken() async {
    //wait until token is set
    while (token == null) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    return token!;
  }
}
