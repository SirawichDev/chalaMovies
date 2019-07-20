import 'package:chalaMovie/model/movie_model.dart';

import './api_provider.dart';

class Repo{
  final movieProvider = ChalaMovieProvider();

  Future<movieModel> fetchAllList() => movieProvider.fetchList();
}