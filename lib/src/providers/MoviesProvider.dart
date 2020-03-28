import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:themoviedbapp/src/models/MovieModel.dart';

class MoviesProvider{

  String _apikey = '7ec8330d6b781b3e3c3c1a93cc13f0df';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

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

      final url = Uri.https(_url, "3/movie/popular", {
        'api_key': _apikey,
        'language': _language
      });

      return await _processResponse(url);

  }

}