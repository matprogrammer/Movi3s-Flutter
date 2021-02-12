import 'package:filmseview/src/providers/movies_provider.dart';
import 'package:filmseview/src/widgets/card_swiper.dart';
import 'package:filmseview/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getMoviesPopulars();
    moviesProvider.getMoviesTopRated();
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
        body: ListView(
          children: [
            Column(
              children: [
                  _swiperCards(),
                  _getMostPopulates(context),
                  _getTopRated(context),
              ],
            )
          ]
        )
      ),
    );
  }


  Widget _getMostPopulates(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
            child:  Text('Most Populars', style: TextStyle(color: Colors.white)),
          ),
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getMoviesPopulars,
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


  Widget _getTopRated(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
            child:  Text('Top rated', style: TextStyle(color: Colors.white)),
          ),
          StreamBuilder(
            stream: moviesProvider.topStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getMoviesTopRated,
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
            movies: snapshot.data,
            layout: SwiperLayout.STACK,
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
