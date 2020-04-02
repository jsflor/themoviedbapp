import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:themoviedbapp/src/models/ActorsModel.dart';
import 'package:themoviedbapp/src/models/MovieModel.dart';

class MoviesProvider{

  String _apikey = '7ec8330d6b781b3e3c3c1a93cc13f0df';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams(){
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final res = await http.get(url);
    final data = json.decode(res.body);

    final movies = new Movies.fromJsonList(data['results']);

    return movies.items;
  }

  Future<List<Movie>> getOnCinema() async {

      final url = Uri.https(_url, "3/movie/now_playing", {
        'api_key': _apikey,
        'language': _language
      });

      return await _processResponse(url);

  }

  Future<List<Movie>> getPopulars() async {

      if(_loading) return [];

      _loading = true;
      _popularsPage++;

      final url = Uri.https(_url, "3/movie/popular", {
        'api_key': _apikey,
        'language': _language,
        'page': _popularsPage.toString()
      });

      final res = await _processResponse(url);

      _populars.addAll(res);
      popularsSink(_populars);

      _loading = false;

      return res;

  }

  Future<List<Actor>> getCast(String movieId) async {

    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apikey,
      'language': _language
    });

    final res = await http.get(url);
    final data = json.decode(res.body);

    final cast = new Cast.fromJsonList(data['cast']);

    return cast.actors;

  }

  Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_url, "3/search/movie/", {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    return await _processResponse(url);

  }

}