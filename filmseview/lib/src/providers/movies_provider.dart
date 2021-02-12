

import 'dart:async';
import 'dart:convert';

import 'package:filmseview/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {

  String _apiKey = 'ab167897daf53af79796dc9da5d56941';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  int _moviesPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();
  List<Movie> _topRated = new List();

  final _popularsSreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularsSink => _popularsSreamController.sink.add;
  Stream<List<Movie>> get popularsStream => _popularsSreamController.stream;

  final _topRatedSreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get topSink => _topRatedSreamController.sink.add;
  Stream<List<Movie>> get topStream => _topRatedSreamController.stream;

  void disposeStreams() {
    _popularsSreamController.close();
    _topRatedSreamController.close();
  }


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

    if (_loading) return [];

    _loading = true;
    _moviesPage++;

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _moviesPage.toString(),
    });

   final resp = await _processResponse(url);
   _populars.addAll(resp);
   popularsSink(_populars);

   _loading = false;
   return resp;

  }

    Future<List<Movie>> getMoviesTopRated() async {

      if (_loading) return [];

      _loading = true;
      _moviesPage++;

      final url = Uri.https(_url, '3/movie/top_rated', {
        'api_key': _apiKey,
        'language': _language,
        'page': _moviesPage.toString(),
      });

    final resp = await _processResponse(url);
    _topRated.addAll(resp);
    topSink(_topRated);

      _loading = false;
    return resp;

  }

}
