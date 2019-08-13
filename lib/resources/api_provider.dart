import 'dart:convert';
import 'package:chalaMovie/model/genre_model.dart';
import 'package:http/http.dart' show Client;
import '../model/movie_model.dart';

class ChalaMovieProvider {
  Client cli = Client();
  final _apiKey = "45802feae9d98fc53bf0b8c6519d6230";
  final _baseMovieUrl = "http://api.themoviedb.org/3/movie";
  final _baseGenreUrl = "http://api.themoviedb.org/3/genre";

  Future<MovieModel> fetchCurrentList(bool isRecent) async {
    print("now playing joined");
    final res = await cli.get(_baseMovieUrl + "/now_playing?api_key=$_apiKey");
    print(res.body.toString());
    if (res.statusCode == 200) {
      return MovieModel.fromJson(json.decode(res.body), isRecent);
    } else {
      throw Exception('failed to load list');
    }
  }

  Future<MovieModel> fetchMostWatcherList(bool isRecent) async {
    print("popular joined");
    final res = await cli.get(_baseMovieUrl + "/popular?api_key=$_apiKey");
    print(res.body.toString());
    if (res.statusCode == 200) {
      return MovieModel.fromJson(json.decode(res.body), isRecent);
    } else {
      throw Exception('failed to load list');
    }
  }

  Future<GenreModel> fetchGenresList() async {
    print("genres joined");
    final res = await cli.get(_baseGenreUrl + "/movie/list?api_key=$_apiKey");
    print(res.body.toString());
    if (res.statusCode == 200) {
      return GenreModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('failed to load list');
    }
  }
}
