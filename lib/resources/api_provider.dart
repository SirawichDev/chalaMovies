import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../model/movie_model.dart';

class ChalaMovieProvider {
  Client cli = Client();
  final _apiKey = "45802feae9d98fc53bf0b8c6519d6230";
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<MovieModel> fetchList() async {
    print("joined");
    final res = await cli
        .get("https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey");
    print(res.body.toString());
    if (res.statusCode == 200) {
      return MovieModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('failed to load list');
    }
  }
}
