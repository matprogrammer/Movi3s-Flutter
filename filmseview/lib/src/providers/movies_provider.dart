

import 'dart:convert';

import 'package:filmseview/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {

  String _apiKey = 'ab167897daf53af79796dc9da5d56941';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';


  Future<List<Movie>> _processResponse(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;

  }


  Future<List<Movie>> getMovies() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _processResponse(url);

  }

  Future<List<Movie>> getMoviesPopulars() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

   return await _processResponse(url);

  }

}
