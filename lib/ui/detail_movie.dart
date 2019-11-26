import 'package:chalaMovie/model/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDeeperDetais extends StatefulWidget {
  Result data;
  String genres;
  MovieDeeperDetais(this.data, this.genres);

  @override
  _MovieDeeperDetaisState createState() => _MovieDeeperDetaisState();
}

class _MovieDeeperDetaisState extends State<MovieDeeperDetais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentPage(widget.data, widget.genres),
    );
  }
}

class ContentPage extends StatefulWidget {
  Result data;
  String genres;
  ContentPage(this.data, this.genres);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Container(
            height: 370,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.topCenter,
                    image: new NetworkImage(
                        widget.data.poster_path.replaceAll("w185", "w400")))),
          ),
          Positioned(
            top: 280,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 8),
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                stops: [0.1, 0.3, .5, .7, .9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.01),
                  Colors.black.withOpacity(.25),
                  Colors.black.withOpacity(.6),
                  Colors.black.withOpacity(.9),
                  Colors.black
                ],
              )),
            ),
          ),
          Positioned(
            left: 20,
            top: 230,
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              child: new Text(
                widget.data.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Positioned(
              top: 275, left: 20, child: GenerateGenresItem(widget.genres))
        ],
      ),
    );
  }
}

class GenerateGenresItem extends StatefulWidget {
  String genres;
  GenerateGenresItem(this.genres);

  @override
  _GenerateGenresItemState createState() => _GenerateGenresItemState();
}

class _GenerateGenresItemState extends State<GenerateGenresItem> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _getGenres(widget.genres),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container();

            default:
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else
                return GetGenres(snapshot);
          }
        });
  }

  Widget GenresItem(String genresName) {
    return (Container(
        decoration: BoxDecoration(
            color: Colors.black38,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: new Text(
            genresName,
            style: TextStyle(color: Colors.white),
          ),
        )));
  }

  Future<List<Widget>> _getGenres(String genre) async {
    var values = new List<Widget>();
    var items = genre.split(',');
    for (int i = 0; i < items.length; i++) {
      values.add(GenresItem(items[i]));
    }
    await new Future.delayed(new Duration(seconds: 5));
    return values;
  }

  Widget GetGenres(AsyncSnapshot snapshot) {
    List<Widget> values = snapshot.data;
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 12,
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: values,
      ),
    );
  }
}
