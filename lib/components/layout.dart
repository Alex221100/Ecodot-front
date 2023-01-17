import 'package:flutter/material.dart';
import 'package:ecodot/components/top_menu.dart';

class MyLayout extends StatefulWidget {
  const MyLayout({super.key, required this.child});
  final Widget child;

  @override
  State<MyLayout> createState() => _MyLayout();
}

class _MyLayout extends State<MyLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TopMenu(),
        ),
        backgroundColor: Color(0xffF4F5FA),
        body: widget.child);
  }
}
