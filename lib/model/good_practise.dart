class GoodPractise {
  late String title;
  late String description;
  late String image;

  GoodPractise() {}

  GoodPractise.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        image = json["image"];

  Map<String, dynamic> toJson() =>
      {"title": title, "description": description, "image": image};
}
