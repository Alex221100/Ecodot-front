class FranceConsumptionValue {
  final String startDate;
  final String endDate;
  final String updatedDate;
  final double value;

  FranceConsumptionValue(
      this.startDate, this.endDate, this.updatedDate, this.value);

  FranceConsumptionValue.fromJson(Map<String, dynamic> json)
      : startDate = json["start_date"],
        endDate = json["end_date"],
        updatedDate = json["updated_date"],
        value = json["value"];
}
