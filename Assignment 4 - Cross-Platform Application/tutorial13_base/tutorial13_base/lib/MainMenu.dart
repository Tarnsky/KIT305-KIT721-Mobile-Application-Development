import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/GameSettings.dart';
import 'package:flutter_tutorial_3/main.dart';

import 'NarBar.dart';

class MainMenu extends StatefulWidget {
  final String title;

  const MainMenu({Key? key, required this.title}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var _counter = 0;
  @override
  Widget build(BuildContext context) {
    var userName;

    if (_counter == 0) {
      userName = 'Sherk';
    } else {
      userName = 'Donkey';
    }
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Stroke of Genuis'),
            Icon(
              Icons.account_tree,
              color: Colors.green,
              size: 30.0,
            ),
            Text('Hello ' + userName),
            SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Play"),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GameSettings(title: 'Game', repLimit: (5))))
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: const Text("History"),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHistory()))
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: const Text("EditName"),
              onPressed: () => {
                setState(() {
                  if (_counter == 0) {
                    _counter++;
                  } else {
                    _counter = 0;
                  }
                })
              },
            ),
          ],
        ),
      ),
    );
  }
}
