import 'package:filmseview/src/models/movie_model.dart';
import 'package:filmseview/src/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies, this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: 170.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) => _createCard(context, movies[i])
      ),
    );

  }

  Widget _createCard(BuildContext context, Movie movie) {
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage(
                image: NetworkImage(
                  movie.getImageMovie(),
                ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 150.0,
              )
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.muli(
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.0),
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MovieDetailsPage(movie)),
        );
      },
    );
  }
}
