import 'package:flutter/material.dart';

class TopMenu extends StatefulWidget {
  const TopMenu({Key? key}) : super(key: key);

  @override
  _TopMenu createState() => _TopMenu();
}

class _TopMenu extends State<TopMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Image(image: AssetImage('ecodot.png')),
        ),
      ),
      backgroundColor: const Color(0xffF4F5FA),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.dark_mode),
            color: const Color.fromRGBO(83, 78, 89, 0.8),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            color: const Color.fromRGBO(83, 78, 89, 0.8),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('avatar-default.png'),
              ),
            ),
          ),
        )
      ],
      elevation: 0,
    );
  }
}
