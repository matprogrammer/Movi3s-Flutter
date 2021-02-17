

import 'package:filmseview/src/models/movie_model.dart';
import 'package:filmseview/src/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;
  final SwiperLayout layout;

  CardSwiper({ @required this.movies, this.layout });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Hero(
            tag: movies[index],
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  image: NetworkImage(
                    movies[index].getImageMovie(),
                  ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                )
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailsPage(movies[index])),
                );
              },
            )
          );
        },
        itemCount: 20,
        layout: layout,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
