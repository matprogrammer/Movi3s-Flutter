

import 'package:filmseview/src/models/movie_model.dart';
import 'package:filmseview/src/pages/movie_details_page.dart';
import 'package:filmseview/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  final moviesProviders = new MoviesProvider();
  Movie selectedMovie;

  @override
  List<Widget> buildActions(BuildContext context) {
      // action appbar
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
      ];
    }

    @override
    Widget buildLeading(BuildContext context) {
      // icon appbar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
    }

    @override
    Widget buildResults(BuildContext context) {
      // result list
     return Container();
    }

    @override
    Widget buildSuggestions(BuildContext context) {

      if (query.isEmpty) {
        return Container();
      }

      return FutureBuilder(
        future: moviesProviders.searchMovie(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

          if (snapshot.hasData) {

            final movies = snapshot.data;

            if (movies.length > 0) {
              return ListView(
                  children: movies.map( (movie) {
                    return ListTile(
                      leading: FadeInImage(
                        image: NetworkImage( movie.getImageMovie() ),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.contain,
                      ),
                      title: Text( movie.title ),
                      subtitle: Text( movie.originalTitle ),
                      onTap: () async {
                        close( context, null);
                        selectedMovie = movie;
                        showResults(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MovieDetailsPage(movie)),
                        );
                      },
                    );
                }).toList()
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 60.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child:
                      Text(
                        "we couldn't find that movie",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
                      ),
                    ),
                  ]
                )
              );
            }

        } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      );
    }

}
