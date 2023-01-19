import 'dart:convert';

import 'package:ecodot/components/sign_in/form_enedis.dart';
import 'package:ecodot/components/sign_in/form_house.dart';
import 'package:ecodot/components/sign_in/form_information.dart';
import 'package:ecodot/components/sign_in/sign_in_dataholder.dart';
import 'package:ecodot/screens/form_enedis_settings.dart';
import 'package:ecodot/screens/public/login.dart';
import 'package:ecodot/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/application_dataholder.dart';
import '../../main.dart';
import '../../model/my_consumption_model.dart';
import '../home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: const Text('Vous'),
        content: Column(
          children: const <Widget>[FormInformation()],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Votre maison'),
        content: const FormHouse(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Enedis'),
        content: const FormEnedis(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];
    return Scaffold(
      body: Theme(
        data: ThemeData(
            colorScheme: const ColorScheme.light(primary: Color(0xff27AF56))),
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    if (_currentStep < 2) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              side: const BorderSide(
                                  width: 1, color: Color(0xff8A8D93)),
                            ),
                            onPressed: details.onStepCancel,
                            child: const Text(
                              'Retour',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xff8A8D93)),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff27AF56),
                              shadowColor: Colors.transparent,
                              side: const BorderSide(
                                  width: 1, color: Color(0xff8A8D93)),
                            ),
                            onPressed: details.onStepContinue,
                            child: const Text(
                              'Suivant',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              side: const BorderSide(
                                  width: 1, color: Color(0xff8A8D93)),
                            ),
                            onPressed: details.onStepCancel,
                            child: const Text(
                              'Retour',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xff8A8D93)),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff7E7E7E),
                              shadowColor: Colors.transparent,
                              side: const BorderSide(
                                  width: 1, color: Color(0xff8A8D93)),
                            ),
                            onPressed: goHome,
                            child: const Text(
                              'Plus tard',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff27AF56),
                              shadowColor: Colors.transparent,
                              side: const BorderSide(
                                  width: 1, color: Color(0xff8A8D93)),
                            ),
                            onPressed: goSetupEnedis,
                            child: const Text(
                              'Terminer',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                  type: StepperType.horizontal,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: steps),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json"
      };

  goSetupEnedis() async{

    String body = jsonEncode({
    'lastname': SignInDataHolder.of(context).user.lastname,
    'firstname': SignInDataHolder.of(context).user.firstname,
    'email': SignInDataHolder.of(context).user.email,
    'password': SignInDataHolder.of(context).user.password,
    'nbPersonHouse': SignInDataHolder.of(context).user.nbPersonHouse,
    'cityCode': SignInDataHolder.of(context).user.cityCode,
    'city': SignInDataHolder.of(context).user.city,
    });

    http.Response response = await http.post(
      Uri.parse(AppConstants.rootURI +
      ":" +
      AppConstants.rootPort +
      "/authentication/signup"),
      headers: headers,
      body: body);
      if (response.body.contains("already exist")){
        Flushbar(
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          message: "Utilisateur déjà existant.",
          backgroundColor: Colors.red,
        )..show(context);
      }
      else{
        http.Response reqlogin = await login(SignInDataHolder.of(context).user.email, SignInDataHolder.of(context).user.password);
        if (reqlogin.statusCode == 200){
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("currentusermail", SignInDataHolder.of(context).user.email);
          ApplicationDataHolder.of(context).applicationStorage.token = reqlogin.body;
          ApplicationDataHolder.of(context).applicationStorage
            .setConsumption(MyConsumptionModel.withValues(1,1,1,1,"1900-01-01"));
          Navigator.push(context,
          MaterialPageRoute<void>(builder: (BuildContext context) {
            return FormEnedisSettings();
          }));
        }
        
      }
  }
  goHome() async {
    //sign in the user
    String body = jsonEncode({
      'lastname': SignInDataHolder.of(context).user.lastname,
      'firstname': SignInDataHolder.of(context).user.firstname,
      'email': SignInDataHolder.of(context).user.email,
      'password': SignInDataHolder.of(context).user.password,
      'nbPersonHouse': SignInDataHolder.of(context).user.nbPersonHouse,
      'cityCode': SignInDataHolder.of(context).user.cityCode,
      'city': SignInDataHolder.of(context).user.city,
    });

    http.Response response = await http.post(
        Uri.parse(AppConstants.rootURI +
            ":" +
            AppConstants.rootPort +
            "/authentication/signup"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      http.Response reqlogin = await login(SignInDataHolder.of(context).user.email, SignInDataHolder.of(context).user.password);
      if (reqlogin.statusCode == 200){
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("currentusermail", SignInDataHolder.of(context).user.email);
        ApplicationDataHolder.of(context).applicationStorage.token = reqlogin.body;
        ApplicationDataHolder.of(context).applicationStorage
          .setConsumption(MyConsumptionModel.withValues(1,1,1,1,"1900-01-01"));
        Navigator.pushNamed(context, "/");
        Flushbar(
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          message: "Bienvenue sur Ecodot !",
          backgroundColor: Colors.green,
        )..show(context);
      }else{
        Navigator.pushNamed(context, "/login");
        Flushbar(
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          message: "Bienvenue sur Ecodot !",
          backgroundColor: Colors.green,
        )..show(context);
        }
    }else if (response.body.contains("already exist")){
        Flushbar(
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          message: "Utilisateur déjà existant.",
          backgroundColor: Colors.red,
        )..show(context);
      }else {
      Flushbar(
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        message: "Une erreur s'est produite. Réessayez plus tard.",
        backgroundColor: Colors.red,
      )..show(context);
    }
  }
  Future<http.Response> login(String email, String password) async {
    String body = jsonEncode({'email': email, 'password': password});

    http.Response response = await http.post(
        Uri.parse(AppConstants.rootURI +
            ":" +
            AppConstants.rootPort +
            "/authentication/login"),
        headers: headers,
        body: body);

    return response;
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
