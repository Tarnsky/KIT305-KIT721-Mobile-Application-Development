import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tutorial_3/FreePlay.dart';
import 'package:flutter_tutorial_3/xPop.dart';
import 'package:provider/provider.dart';
import 'FreePlay2.dart';
import 'FreePlay4.dart';
import 'FreePlay5.dart';
import 'FreePlay5No.dart';
import 'FreePlayNo.dart';
import 'FreePlayNo2.dart';
import 'FreePlayNo4.dart';
import 'gamePlay.dart';
import 'gamePlay2.dart';
import 'gamePlay4.dart';
import 'gamePlayNo4.dart';
import 'gamePlay5.dart';
import 'gamePlayNo5.dart';
import 'gamePlayNo.dart';
import 'gamePlay2No.dart';
import 'movie_details.dart';
import 'movie.dart';
import 'NarBar.dart';

class GameSettings extends StatefulWidget {
  GameSettings({Key? key, required this.title, required this.repLimit})
      : super(key: key);

  final String title;
  final int repLimit;
  @override
  _GameSettings createState() => _GameSettings();
}

class _GameSettings extends State<GameSettings> {
  final reps = [5, 10, 15, 20];
  int? _value = 5;
  int? _randValue;
  int? _buttonValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text('Selected Number of Reps'),
            DropdownButton(
              items: const [
                DropdownMenuItem(child: Text('5'), value: 5),
                DropdownMenuItem(child: Text('10'), value: 10),
                DropdownMenuItem(child: Text('15'), value: 15),
                DropdownMenuItem(child: Text('20'), value: 20),
              ],
              value: _value,
              onChanged: dropdownCallback,
            ),
            SizedBox(height: 30),
            Text('Randomise Numbers?'),
            DropdownButton(
              items: const [
                DropdownMenuItem(child: Text('Yes'), value: 1),
                DropdownMenuItem(child: Text('No'), value: 2),
              ],
              value: _randValue,
              onChanged: dropdownCallbackRand,
            ),
            SizedBox(height: 30),
            Text('Number of buttons'),
            DropdownButton(
              items: const [
                DropdownMenuItem(child: Text('2'), value: 2),
                DropdownMenuItem(child: Text('3'), value: 3),
                DropdownMenuItem(child: Text('4'), value: 4),
                DropdownMenuItem(child: Text('5'), value: 5),
              ],
              value: _buttonValue,
              onChanged: dropdownCallbackButton,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: const Text("TapTapReHab"),
              onPressed: () => {
                if (_randValue == 1)
                  {
                    if (_buttonValue == 3)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlay(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 2)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlay2(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 4)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlay4(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 5)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlay5(
                                    title: 'Game', repLimit: (_value))))
                      }
                  }
                else
                  {
                    if (_buttonValue == 3)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlayNo(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 2)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlayNo2(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 4)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlayNo4(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 5)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePlayNo5(
                                    title: 'Game', repLimit: (_value))))
                      }
                  }
              },
            ),
            ElevatedButton(
              child: const Text("FreePlay"),
              onPressed: () => {
                if (_randValue == 1)
                  {
                    if (_buttonValue == 3)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlay(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 2)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlay2(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 4)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlay4(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 5)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlay5(
                                    title: 'Game', repLimit: (_value))))
                      }
                  }
                else
                  {
                    if (_buttonValue == 3)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlayNo(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 2)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlayNo2(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 4)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlayNo4(
                                    title: 'Game', repLimit: (_value))))
                      },
                    if (_buttonValue == 5)
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreePlayNo5(
                                    title: 'Game', repLimit: (_value))))
                      }
                  }
              },
            ),
            ElevatedButton(
              child: const Text("xPop mini game"),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            xPop(title: 'Game', repLimit: (_value))))
              },
            ),
          ],
        ),
      ),
    );
  }

  void dropdownCallback(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        _value = selectedValue;
      });
    }
  }

  void dropdownCallbackButton(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        _buttonValue = selectedValue;
      });
    }
  }

  void dropdownCallbackRand(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        _randValue = selectedValue;
      });
    }
  }

  Scaffold buildScaffold(BuildContext context, MovieModel movieModel, _) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Game Set-up'),
      ),
    );
  }
}

class FullScreenText extends StatelessWidget {
  final String text;

  const FullScreenText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Column(children: [Expanded(child: Center(child: Text(text)))]));
  }
}
