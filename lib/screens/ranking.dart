import 'package:ecodot/components/layout.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _Ranking();
}

class _Ranking extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return const MyLayout(child: FutureBuilder(future: Future.wait()
        builder: (context, AsyncSnapshot snapshot) {


    }));
  }
}
