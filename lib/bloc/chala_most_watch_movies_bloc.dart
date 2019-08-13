import 'package:chalaMovie/model/movie_model.dart';
import 'package:chalaMovie/resources/repo.dart';
import 'package:rxdart/rxdart.dart';

class ChalaMoviesBloc {
  final repo = Repo();
  final movieFetch = PublishSubject<MovieModel>();

  Observable<MovieModel> get allMostWatcherMovies => movieFetch.stream;

  fetchAllMostWatchMovies() async {
    MovieModel mModel = await repo.fetchAllMostMovieList();
    movieFetch.sink.add(mModel);

  }

  dispose(){
    movieFetch.close();
  }
}

final bloc_most_watcher = ChalaMoviesBloc();
