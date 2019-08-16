class GenreModel {
  List<Result> results = [];

  GenreModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Result> temp = [];
    for (var i = 0; i < parsedJson['genres'].length; i++) {
      Result result = Result(parsedJson['genres'][i]);
      temp.add(result);
    }
    temp = temp.toSet().toList();
    results = temp;
  }

  List<Result> get get_genres => results;

  String get_genre(List<int> ids) {
    ids = ids.toSet().toList();
    String mygenre = "";
    for (var i = 0; i < ids.length; i++) {
      mygenre += results.where((user) => user.id == ids[i]).first.name + ",";
    }
    mygenre = mygenre.substring(0, mygenre.length -1);
    return mygenre;
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
