import 'package:flutter/material.dart';
import 'package:ecodot/components/top_menu.dart';
import '../inputfields.dart';

class FormEnedis extends StatefulWidget {
  const FormEnedis({super.key});

  @override
  State<FormEnedis> createState() => _FormEnedis();
}

class _FormEnedis extends State<FormEnedis> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Connexion à Enedis",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Si vous possédez un compteur Linky, il est possible de récupérer votre consommation pour vous aider à faire des économies.",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff27AF56), Color(0xffC4FF00)]),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {},
                child: const Text(
                  'Redirection Enedis ->',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
