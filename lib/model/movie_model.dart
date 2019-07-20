class movieModel {
  int page;
  int total_page;
  int total_results;
  List<Result> results = [];

  movieModel.fromJson(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    total_results = parsedJson['total_results'];
    total_page = parsedJson['total_page'];
    List<Result> temp = [];
    for (var i = 0; i < parsedJson['results'].length; i++) {
     Result result = Result(parsedJson['result'](i));
     temp.add(result);
    }
    results = temp;
  }
}

class Result {
  String vote_count;
  int id;
  bool video;
  var vote_avarage;
  String title;
  double popularity;
  String poster_path;
  List<int> genre_ids = [];
  String backdrop_path;
  bool adult;
  String overview;
  String release_date;

  Result(result) {
    vote_count = result['vote_count'].toString();
    id = result['id'];
    video = result['video'];
    vote_avarage = result['vote_avarage'];
    title = result['title'];
    popularity = result['popularity'];
    poster_path = result['poster_path'];

    for (var i = 0; i < result['genre_ids'].length; i++) {
      genre_ids.add(result['genre_ids'][i]);
    }
    backdrop_path = result['backdrop_path'];
    adult = result['adult'];
    overview = result['overview'];
    release_date = result['release_date'];
  }
  String get fetch_release_date => release_date;
  String get fetch_backdrop_path => backdrop_path;
  String get fetch_overview => overview;
  bool get fetch_adult => adult;
  List<int> get fetch_genre_ids => genre_ids;
  String get fetch_poster_path => poster_path;
  double get fetch_popularity => popularity;
  String get fetch_title => title;
  String get fetch_vote_average => vote_avarage;
  bool get have_video => video;
  int get fetch_id => id;
  String get fetch_vote_count => vote_count;

}
