class MyConsumptionModel {
  late double dailyConsumption;
  late double weeklyConsumption;
  late double monthlyConsumption;
  late double yearlyConsumption;
  late String date;

  MyConsumptionModel();

  //constructor with all values
  MyConsumptionModel.withValues(
      this.dailyConsumption,
      this.weeklyConsumption,
      this.monthlyConsumption,
      this.yearlyConsumption,
      this.date);

  MyConsumptionModel.fromJson(Map<String, dynamic> json):
    dailyConsumption = json["dayConsumtion"],
    weeklyConsumption = json["weekConsumtion"],
    monthlyConsumption = json["monthConsumtion"],
    yearlyConsumption = json["yearConsumtion"],
    date = json["date"];

  Map<String, dynamic> toJson() =>
      {
        "dailyConsumption": dailyConsumption, 
        "weeklyConsumption": weeklyConsumption, 
        "monthlyConsumption": monthlyConsumption, 
        "yearlyConsumption": yearlyConsumption,
        "date": date
      };

  //getter setter
  double? getDailyConsumption() => dailyConsumption/1000;
  double? getWeeklyConsumption() => weeklyConsumption/1000;
  double? getMonthlyConsumption() => monthlyConsumption/1000;
  double? getYearlyConsumption() => yearlyConsumption/1000;
  String? getDate() => date ?? "01-01-1900";
}
