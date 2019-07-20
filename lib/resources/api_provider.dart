import 'package:http/http.dart';
import '../model/movie_model.dart';
import 'dart:convert';

class ChalaMovieProvider {
  Client cli = Client();
  final apiKey = "";
  final baseUrl = "";

  Future<movieModel> fetchList() async {
    final res = await cli.get("");
    if (res.statusCode == 200) {
      return movieModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('failed to load list');
    }
  }
}
