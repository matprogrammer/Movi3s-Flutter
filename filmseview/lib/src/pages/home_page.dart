import 'package:filmseview/src/providers/movies_provider.dart';
import 'package:filmseview/src/widgets/card_swiper.dart';
import 'package:filmseview/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies'),
        backgroundColor: Colors.blueGrey[800],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperCards(),
            _footer(context),
          ],
        )
      ),
    );
  }


  Widget _footer(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
           margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
           child:  Text('Most Populars', style: TextStyle(color: Colors.white)),
         ),
          FutureBuilder(
            future: moviesProvider.getMoviesPopulars(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data
                );
              } else {
                return Container(
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
                );
              }
            }
          ),
        ],
      ),
    );
  }


  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data
          );
        } else {
          return Container(
            height: 200.0,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      }
    );
  }


}
