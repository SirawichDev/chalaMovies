class GenreModel {
  List<Result> results = [];

  GenreModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Result> temp = [];
    for (var i = 0; i < parsedJson['genres'].length; i++) {
      Result result = Result(parsedJson['genres'][i]);
      temp.add(result);
    }

    results = temp;
  }
}

class Result {
  int id;
  String name;

  Result(result) {
    id = result['id'];
    name = result['name'].toString();
  }

  String get get_name => name;

  int get get_id => id;
}
