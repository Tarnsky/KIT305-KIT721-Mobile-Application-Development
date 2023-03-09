import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/GameSettings.dart';
import 'MainMenu.dart';
import 'main.dart';
import 'GameSettings.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_tutorial_3/MainMenu.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    var userName = 'Sherk';
    return Drawer(
        child: ListView(
      children: [
        SizedBox(height: 30),
        ListTile(
            title: Text('Menu'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainMenu(title: 'Menu')));
            }),
        SizedBox(height: 30),
        ListTile(
            title: Text('Play'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameSettings(
                            title: 'Game Set-up',
                            repLimit: 5,
                          )));
            }),
        SizedBox(height: 30),
        ListTile(
            title: Text('History'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHistory()));
            }),
      ],
    ));
  }
}
