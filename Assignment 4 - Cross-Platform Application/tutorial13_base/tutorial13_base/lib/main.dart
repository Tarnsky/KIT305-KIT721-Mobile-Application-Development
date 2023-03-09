import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'movie_details.dart';
import 'movie.dart';
import 'NarBar.dart';

Future main() async {
  //converted main() to be an asynchronous function
  WidgetsFlutterBinding.ensureInitialized(); //added this line
  await initializeFirebase(); //added this line too
  runApp(MyHistory());
}

class MyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context,
              snapshot) //this function is called every time the "future" updates
          {
        // Check for errors
        if (snapshot.hasError) {
          return FullScreenText(text: "Something went wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          //BEGIN: the old MyApp builder from last week
          return ChangeNotifierProvider(
              create: (context) => MovieModel(),
              child: MaterialApp(
                  title: 'Stroke of Genius',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: MyHomePage(title: 'Stroke of Genius - History')));
          //END: the old MyApp builder from last week
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FullScreenText(text: "Loading");
      },
    );
  }
}

Future<FirebaseApp> initializeFirebase() async {
  if (kIsWeb) {
    return await Firebase.initializeApp(
        options: FirebaseOptions(

            //get this information from the firebase console
            apiKey: "GET",
            authDomain: "THIS",
            projectId: "INFORMATION",
            storageBucket: "FROM",
            messagingSenderId: "THE",
            appId: "FIREBASE",
            measurementId: "CONSOLE"));
  } else {
    //android and ios get config from the GoogleServices.json and .plist files
    return await Firebase.initializeApp();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHistory createState() => _MyHistory();
}

class _MyHistory extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieModel>(builder: buildScaffold);
  }

  Scaffold buildScaffold(BuildContext context, MovieModel movieModel, _) {
    var userName = 'Sherk';
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),

/*      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return MovieDetails();
          });
        },
      ),*/

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //YOUR UI HERE
            if (movieModel.loading)
              CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                    itemBuilder: (_, index) {
                      var movie = movieModel.items[index];
                      var image = movie.image;
                      return ListTile(
                        title: Text(movie.title),
                        subtitle: Text("Score: " +
                            movie.year.toString() +
                            " - Start Time: " +
                            movie.duration.toString() +
                            " - End Time: " +
                            movie.end.toString() +
                            " - Total Clicks: " +
                            movie.totalClicks.toString() +
                            " - Total correct Clicks: " +
                            movie.totalRightClicks.toString()),
                        leading: image != null ? Image.network(image) : null,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MovieDetails(id: movie.id);
                          }));
                        },
                      );
                    },
                    itemCount: movieModel.items.length),
              )
          ],
        ),
      ),
    );
  }
}

//A little helper widget to avoid runtime errors -- we can't just display a Text() by itself if not inside a MaterialApp, so this workaround does the job
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
