import 'package:ecodot/components/sign_in/form_enedis.dart';
import 'package:ecodot/components/sign_in/form_house.dart';
import 'package:ecodot/components/sign_in/form_information.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
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
                            onPressed: goHome,
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

  goHome() {
    Navigator.pushNamed(context, '/home');
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
