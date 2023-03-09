import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  String id; //(1)
  String title;
  int year;
  String duration;
  String? image;
  String end;
  int totalClicks;
  int totalRightClicks;

  //(2)
  Movie(
      {required this.id,
      required this.title,
      required this.year,
      required this.duration,
      required this.end,
      required this.totalClicks,
      required this.totalRightClicks,
      this.image});

  Movie.fromJson(Map<String, dynamic> json, String id) //(3)
      : id = id, //(4)
        title = json['title'],
        year = json['year'], //score
        duration = json['duration'],
        end = json['end'],
        totalClicks = json['totalClicks'],
        totalRightClicks = json['totalRightClicks'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'year': year,
        'duration': duration,
        'end': end,
        'totalClicks': totalClicks,
        'totalRightClicks': totalRightClicks,
        'image': image
      };
}

class MovieModel extends ChangeNotifier {
  /// Internal, private state of the list.
  final List<Movie> items = [];

  CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('moviesFlutter');

  bool loading = false;

  MovieModel() {
    fetch();
  }
  Future add(Movie item) async {
    loading = true;
    update();

    await moviesCollection.add(item.toJson());

    //refresh the db
    await fetch();
  }

  Future updateItem(String id, Movie item) async {
    loading = true;
    update();

    await moviesCollection.doc(id).set(item.toJson());

    //refresh the db
    await fetch();
  }

  Future delete(String id) async {
    loading = true;
    update();

    await moviesCollection.doc(id).delete();

    //refresh the db
    await fetch();
  }

  // This call tells the widgets that are listening to this model to rebuild.
  void update() {
    notifyListeners();
  }

  Future fetch() async {
    //clear any existing data we have gotten previously, to avoid duplicate data
    items.clear();

    //indicate that we are loading
    loading = true;
    notifyListeners(); //tell children to redraw, and they will see that the loading indicator is on

    //get all movies
    var querySnapshot = await moviesCollection.orderBy("title").get();

    //iterate over the movies and add them to the list
    querySnapshot.docs.forEach((doc) {
      //note not using the add(Movie item) function, because we don't want to add them to the db
      var movie = Movie.fromJson(doc.data()! as Map<String, dynamic>, doc.id);
      items.add(movie);
    });

    //put this line in to artificially increase the load time, so we can see the loading indicator (when we add it in a few steps time)
    //comment this out when the delay becomes annoying
    await Future.delayed(Duration(seconds: 2));

    //we're done, no longer loading
    loading = false;
    update();
  }

  Movie? get(String? id) {
    if (id == null) return null;
    return items.firstWhere((movie) => movie.id == id);
  }
}
