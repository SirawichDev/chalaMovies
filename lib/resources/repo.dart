import 'package:chalaMovie/model/genre_model.dart';
import 'package:chalaMovie/model/movie_model.dart';

import './api_provider.dart';

class Repo{
  final movieProvider = ChalaMovieProvider();

  Future<MovieModel> fetchAllList() => movieProvider.fetchCurrentList(true);
  Future<MovieModel> fetchAllMostMovieList() => movieProvider.fetchMostWatcherList(false);
  Future<GenreModel> fetchAllGenreList() => movieProvider.fetchGenresList();
}