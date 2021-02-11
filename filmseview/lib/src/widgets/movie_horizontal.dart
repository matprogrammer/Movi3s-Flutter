import 'package:filmseview/src/models/movie_model.dart';
import 'package:flutter/material.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  MovieHorizontal({ @required this.movies });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _cards(context)
      ),
    );

  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((m) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage(
                image: NetworkImage(
                  m.getImageMovie(),
                ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 150.0,
              )
            ),
            SizedBox(height: 5.0),
            Text(
              m.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            )
          ],
        ),
      );
    }).toList();
  }


}
