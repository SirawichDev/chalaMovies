import 'package:chalaMovie/model/movie_model.dart';
import 'package:chalaMovie/resources/repo.dart';
import 'package:rxdart/rxdart.dart';

class ChalaMoviesBloc {
  final repo = Repo();
  final movieFetch = PublishSubject<MovieModel>();

  Observable<MovieModel> get allMovies => movieFetch.stream;

  fetchAllMovies() async {
    MovieModel mModel = await repo.fetchAllList();
    movieFetch.sink.add(mModel);
  }

  dispose() {
    movieFetch.close();
  }
}

final bloc = ChalaMoviesBloc();
