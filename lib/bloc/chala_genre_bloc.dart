import 'package:chalaMovie/model/genre_model.dart';
import 'package:chalaMovie/resources/repo.dart';
import 'package:rxdart/rxdart.dart';

class ChalaGenreBloc {
  final repo = Repo();
  final genreFetch = PublishSubject<GenreModel>();

  Observable<GenreModel> get allGenres => genreFetch.stream;

  fetchAllGenre() async {
    GenreModel mModel = await repo.fetchAllGenreList();
    genreFetch.sink.add(mModel);
  }

  dispose() {
    genreFetch.close();
  }
}

final bloc_genre = ChalaGenreBloc();
