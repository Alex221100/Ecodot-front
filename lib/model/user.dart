class User {
  late String lastname;
  late String firstname;
  late String email;
  late String password;
  late int nbPersonHouse;
  late String cityCode;
  late String city;

  User() {}

  setLastname(String userLastname) {
    lastname = userLastname;
  }

  setFirstname(String userFirstname) {
    firstname = userFirstname;
  }

  setEmail(String userEmail) {
    email = userEmail;
  }

  setPassword(String userPassword) {
    password = userPassword;
  }

  setNbPersonHouse(int userNbPersonHouse) {
    nbPersonHouse = userNbPersonHouse;
  }

  setCityCode(String userCityCode) {
    cityCode = userCityCode;
  }

  setCity(String userCity) {
    city = userCity;
  }

  User.fromJson(Map<String, dynamic> json)
      : lastname = json["lastname"],
        firstname = json["firstname"],
        email = json["email"],
        password = json["password"],
        nbPersonHouse = json["nbPersonHouse"],
        cityCode = json["cityCode"],
        city = json["city"];

  Map<String, dynamic> toJson() => {
        "lastname": lastname,
        "firstname": firstname,
        "email": email,
        "password": password,
        "nbPersonHouse": nbPersonHouse,
        "cityCode": cityCode,
        "city": city
      };
}
