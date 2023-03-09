import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tutorial_3/MainMenu.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'movie_details.dart';
import 'movie.dart';
import 'NarBar.dart';
import 'GameSettings.dart';

class FreePlay extends StatefulWidget {
  FreePlay({Key? key, required this.title, required this.repLimit})
      : super(key: key);

  final String title;
  final int? repLimit;

  @override
  _FreePlay createState() => _FreePlay();
}

class _FreePlay extends State<FreePlay> {
  int? scoreLimit = _FreePlay.repLimit;
  int score = 0;
  int totalClicks = 0;
  int totalRightClicks = 0;
  int totalWrongClicks = 0;
  int tracker = 1;
  bool hasGameStared = false;
  static int? repLimit;
  bool buttonChange = false;
  var sizeWidth = 50.0;
  var sizeHight = 50.0;
  bool showTracker = false;
  var buttonTrackerText = 'Next button: ';
  var title;
  var year;
  var duration;
  var end;

  void _incrementTrackerCounter() {
    setState(() {
      if (score == 0 && tracker == 1) {
        duration = DateTime.now().toString();
      }
      tracker++;
      if (tracker == 4) {
        tracker = 1;
        score++;
      }
    });
  }

  void _showTrackerCounter() {
    setState(() {
      if (showTracker == true) {
        buttonTrackerText = 'Next button: ';
        showTracker = false;
      } else {
        buttonTrackerText = '';
        showTracker = true;
      }
    });
  }

  void _incrementRightCounter() {
    totalClicks++;
    totalRightClicks++;
  }

  void _incrementWrongCounter() {
    totalClicks++;
    totalWrongClicks++;
  }

  void _incrementButtonSize() {
    setState(() {
      if (buttonChange == true) {
        sizeWidth = 50.0;
        sizeHight = 50.0;
        buttonChange = false;
      } else {
        sizeWidth = 80.0;
        sizeHight = 80.0;
        buttonChange = true;
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('GameOver'),
            actions: [
              MaterialButton(
                  onPressed: () {
                    //return to previous screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainMenu(title: 'MainMenu')));
                  },
                  child: Text('OK')),
              MaterialButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> addMoive() {
    CollectionReference moviesCollection =
        FirebaseFirestore.instance.collection('moviesFlutter');
    // Calling the collection to add a new user
    return moviesCollection
        //adding to firebase collection
        .add({
          //Data added in the form of a dictionary into the document.
          'title': title,
          'year': year,
          'duration': duration,
          'end': end,
          'totalClicks': totalClicks,
          'totalRightClicks': totalRightClicks
        })
        .then((value) => print("Game data Added"))
        .catchError((error) => print("Game couldn't be added."));
  }

  void endGame() {
    title = 'FreePlay3';
    year = score;
    end = DateTime.now().toString();
    addMoive();
    _showDialog();
  }

  @override
  Widget build(BuildContext context) {
    var numberList = [1, 2, 3];
    numberList.shuffle();
    int buttonA = numberList[0];
    int buttonB = numberList[1];
    int buttonC = numberList[2];
/*    print("A " + buttonA.toString());
    print("B " + buttonB.toString());
    print("C " + buttonC.toString());
    print("Traker " + tracker.toString());
    print("Right " + totalRightClicks.toString());
    print("Wrong " + totalWrongClicks.toString());
    print("Total " + totalClicks.toString());*/
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('FreePlay3'),
              Text('Press The button in Order to score'),
              Text(buttonTrackerText + tracker.toString()),
              Text('Score: ' + '$score'),
              SizedBox(height: 30),
              Container(
                height: sizeHight,
                width: sizeWidth,
                child: FloatingActionButton(
                  child: Text(buttonA.toString()),
                  onPressed: () {
                    if (buttonA == tracker) {
                      _incrementTrackerCounter();
                      _incrementRightCounter();
                    } else {
                      _incrementWrongCounter();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: sizeHight,
                width: sizeWidth,
                child: FloatingActionButton(
                  child: Text(buttonB.toString()),
                  onPressed: () {
                    if (buttonB == tracker) {
                      _incrementTrackerCounter();
                      _incrementRightCounter();
                    } else {
                      _incrementWrongCounter();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: sizeHight,
                width: sizeWidth,
                child: FloatingActionButton(
                  child: Text(buttonC.toString()),
                  onPressed: () {
                    if (buttonC == tracker) {
                      _incrementTrackerCounter();
                      _incrementRightCounter();
                    } else {
                      _incrementWrongCounter();
                    }
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: const Text("Change Button Size"),
                onPressed: () {
                  _incrementButtonSize();
                },
              ),
              ElevatedButton(
                child: const Text("Disable/Enable next-button indication"),
                onPressed: () {
                  _showTrackerCounter();
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: const Text("End Game"),
                onPressed: () {
                  endGame();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
