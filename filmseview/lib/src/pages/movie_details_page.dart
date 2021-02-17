import 'package:filmseview/src/models/actors_model.dart';
import 'package:filmseview/src/models/movie_model.dart';
import 'package:filmseview/src/providers/movies_provider.dart';
import 'package:filmseview/src/widgets/favorite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailsPage extends StatelessWidget {

  final Movie movie;
  MovieDetailsPage(this.movie);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _createInfoWidget(movie),
            _descriptionWidget(movie),
            _createCast(movie),
          ])),
        ],
      )
    );
  }

  Widget _createInfoWidget(Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                  image: NetworkImage(movie.getImageMovie()),
                  height: 150.0,
                )
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  movie.title,
                  style: GoogleFonts.muli(
                    textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  movie.originalTitle,
                  style: GoogleFonts.muli(
                    textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 10.0),
                  ),
                ),
              ),
              Row(
                children: [
                  _ratingWidget(movie),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey[800],
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            movie.title,
            style: GoogleFonts.muli(
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16.0, shadows: [
                 Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),

              ]
            ),
          ),
        ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.getBackgroundMovie()),
          fit: BoxFit.cover,
        ),
      ),
      actions: <Widget>[
        new Favorite(movieId: movie.id)
      ],
    );

  }

  Widget _descriptionWidget(Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'About: ',
              style: GoogleFonts.muli(
                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14.0),
              ),
            ),
          ),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12.0),
            ),
          )
        ],
      )
    );

  }

  Widget _ratingWidget(Movie movie) {
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: _generateColorRating(movie.voteAverage.toInt()),
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.star_rate_sharp, color: Colors.white, size: 18.0,),
              Padding(
                padding: EdgeInsets.only(left: 1.0),
                child: Text(
                  movie.voteAverage.toString(),
                  style: GoogleFonts.muli(
                    textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _createCast(Movie movie) {

    final moviesProvide = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvide.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return _actorsWidget(snapshot.data);
        } else {
          return Container(
            height: 100.0,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      }
      );
  }

  Widget _actorsWidget(List<Actor> actores ) {
    return (
      SizedBox(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
          itemCount: actores.length,
          itemBuilder: (context, i) => _actorCardWidget(actores[i])
      ),
    )
  );
}

Widget _actorCardWidget(Actor actor) {
  return Container(
    child: Column(
      children: [
       ClipRRect(
         borderRadius: BorderRadius.circular(8.0),
         child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(actor.getImageActor()),
          height: 150.0,
          width: 100.0,
          fit: BoxFit.cover
        )
       ),
       Padding(
         padding: EdgeInsets.only(top: 5.0),
         child: Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.muli(
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.0),
            ),
          ),
        )
      ],
    ),
  );
}


Color _generateColorRating(int rating) {
  if (rating == 0) {
    return Colors.redAccent;
  } else if (rating > 0 && rating <= 3) {
    return Colors.orangeAccent;
  } else if (rating >= 4 && rating < 7) {
    return Colors.yellowAccent;
  } else if (rating >= 7 && rating <= 10) {
    return Colors.lightGreenAccent;
  }
  return Colors.lightGreenAccent;
}



}

