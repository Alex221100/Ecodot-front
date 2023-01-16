class MyConsumptionModel {
  late String dailyConsumption;
  late String weeklyConsumption;
  late String monthlyConsumption;
  late String yearlyConsumption;
  late String date;

  MyConsumptionModel();

  MyConsumptionModel.fromJson(Map<String, dynamic> json):
    dailyConsumption = json["dailyConsumption"],
    weeklyConsumption = json["weeklyConsumption"],
    monthlyConsumption = json["monthlyConsumption"],
    yearlyConsumption = json["yearlyConsumption"],
    date = json["date"];

  Map<String, dynamic> toJson() =>
      {
        "dailyConsumption": dailyConsumption, 
        "weeklyConsumption": weeklyConsumption, 
        "monthlyConsumption": monthlyConsumption, 
        "yearlyConsumption": yearlyConsumption,
        "date": date
      };
}
