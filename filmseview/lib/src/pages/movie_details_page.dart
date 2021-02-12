import 'package:filmseview/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {

  final Movie movie;
  MovieDetailsPage(this.movie);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(movie.title),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Text(movie.title),
    );
  }
}
