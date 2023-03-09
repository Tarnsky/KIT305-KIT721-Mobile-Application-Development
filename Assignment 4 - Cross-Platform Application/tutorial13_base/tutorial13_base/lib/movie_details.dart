import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/main.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'GameSettings.dart';
import 'movie.dart';

class MovieDetails extends StatefulWidget {
  final String? id;

  const MovieDetails({Key? key, this.id}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final durationController = TextEditingController();
  final endController = TextEditingController();
  final totalController = TextEditingController();
  final totalRightController = TextEditingController();
  final imageController = TextEditingController();
  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want to delete this Session?'),
            content: Text('This cannot be undone'),
            actions: [
              MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await Provider.of<MovieModel>(context, listen: false)
                          .delete(widget.id!);

                      //return to previous screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyHistory()));
                    }
                  },
                  child:
                      Text('DELETE', style: TextStyle(color: Colors.red[800]))),
              MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }

  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  @override
  Widget build(BuildContext context) {
    var movie = Provider.of<MovieModel>(context, listen: false).get(widget.id);

    var adding = movie == null;
    if (!adding) {
      titleController.text = movie.title;
      yearController.text = movie.year.toString();
      durationController.text = movie.duration.toString();
      endController.text = movie.end.toString();
      totalController.text = movie.totalClicks.toString();
      totalRightController.text = movie.totalRightClicks.toString();
      imageController.text = movie.image.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(adding ? "Add Movie" : "Edit Movie"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(32),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      if (adding == false)
                        Text(
                            "Game Session ${widget.id}"), //check out this dart syntax, lets us do an if as part of an argument list
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: "Title"),
                                controller: titleController,
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: "Score"),
                                controller: yearController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Start Time"),
                                controller: durationController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "End Time"),
                                controller: endController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Total Clicks"),
                                controller: totalController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Total Correct Clicks"),
                                controller: totalRightController,
                              ),

/*                              ElevatedButton.icon(
                                  onPressed: () async {
                                    //this function is asynchronous now
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      if (adding) {
                                        movie = Movie(
                                            id: "",
                                            title: "",
                                            duration: "",
                                            end: "",
                                            totalClicks: 0,
                                            totalRightClicks: 0,
                                            year: 0);
                                      }

                                      //update the movie object
                                      movie!.title = titleController.text;
                                      movie!.year = int.parse(yearController
                                          .text); //good code would validate these
                                      movie!.duration = durationController
                                          .text; //good code would validate these
                                      movie!.end = endController.text;
                                      movie!.totalClicks = int.parse(totalController
                                          .text);
                                      movie!.totalRightClicks = int.parse(totalRightController
                                          .text);
                                      if (adding)
                                        await Provider.of<MovieModel>(context,
                                                listen: false)
                                            .add(movie!);
                                      else
                                        await Provider.of<MovieModel>(context,
                                                listen: false)
                                            .updateItem(widget.id!, movie!);

                                      //return to previous screen
                                      Navigator.pop(context);
                                    }
                                  },
                                  icon: const Icon(Icons.save),
                                  label: const Text("Save Values")),*/
                              // ElevatedButton.icon(onPressed: () async {
                              //     _showDialog();
                              // }, icon: const Icon(Icons.delete), label: const Text("Delete alert")
                              // ),
                              //share_plus 4.0.7
                              ElevatedButton(
                                child: Text("Share Session"),
                                onPressed: () async {
                                  await Share.share('share ' +
                                      titleController.toString() +
                                      'Total Correct Clicks ' +
                                      totalRightController.toString());
                                },
                              ),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    //this function is asynchronous now

                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _showDialog();
                                    }
                                    // {
                                    //   await Provider.of<MovieModel>(context, listen:false).delete(widget.id!);
                                    //
                                    //   //return to previous screen
                                    //   Navigator.pop(context);
                                    // }
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Delete Session")),
                              ElevatedButton(
                                onPressed: () async {
                                  pickedFile = picker
                                          .pickImage(
                                            source: ImageSource.gallery,
                                          )
                                          .whenComplete(() => {setState(() {})})
                                      as Future<PickedFile?>;
                                  movie!.image = pickedFile.toString();
                                  await Provider.of<MovieModel>(context,
                                          listen: false)
                                      .updateItem(widget.id!, movie!);
                                },
                                child: Text('Add Picture'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]))));
  }
}
