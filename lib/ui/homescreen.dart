import 'package:chalaMovie/bloc/chala_genre_bloc.dart';
import 'package:chalaMovie/bloc/chala_most_watch_movies_bloc.dart';
import 'package:chalaMovie/model/genre_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/chala_movies_bloc.dart';
import 'dart:math';
import '../model/movie_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller;
  double bgHeight = 300.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        bgHeight =
            max(0, MediaQuery.of(context).size.height - _controller.offset);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        controller: _controller,
        children: <Widget>[PreloadContent()],
      ),
    );
  }
}

class PreloadContent extends StatefulWidget {
  @override
  _PreloadContentState createState() => _PreloadContentState();
}

class _PreloadContentState extends State<PreloadContent> {
  @override
  Widget build(BuildContext context) {
    bloc_genre.fetchAllGenre();
    return StreamBuilder(
      stream: bloc_genre.allGenres,
      builder: (context, AsyncSnapshot<GenreModel> snapshot) {
        if (snapshot.hasData) {
          return ContentPage(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ContentPage extends StatefulWidget {
  AsyncSnapshot<GenreModel> snapshotGenres;

  ContentPage(this.snapshotGenres);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 100,
          color: Colors.black.withOpacity(.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                'Search',
                style: TextStyle(
                    fontFamily: 'RictyDiminished-Regular',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(color: Colors.grey, fontSize: 24.0),
                decoration: new InputDecoration.collapsed(
                    hintText: 'Movie, Actors,Directors..',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 24.0)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 24,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: new Text(
                        'Recent',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 20,
                      child: new Text(
                        'See All',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              CurrentMovies(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 28,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: new Text(
                        "Most Watch",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 20,
                      child: new Text(
                        "See All",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              MostWatcher(widget.snapshotGenres)
            ],
          ),
        ),
      ],
    );
  }
}

class CurrentMovies extends StatefulWidget {
  @override
  _CurrentMoviesState createState() => _CurrentMoviesState();
}

class _CurrentMoviesState extends State<CurrentMovies> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<MovieModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.all(3),
            width: MediaQuery.of(context).size.width - 20,
            height: 300,
            child: MCardLoad(snapshot),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MCardLoad extends StatefulWidget {
  AsyncSnapshot<MovieModel> snapshot;

  MCardLoad(this.snapshot);

  @override
  _MCardLoadState createState() => _MCardLoadState();
}

class _MCardLoadState extends State<MCardLoad> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ConstrainedBox(
                constraints: new BoxConstraints(
                    maxHeight: 290.0,
                    minHeight: 190.0,
                    minWidth: MediaQuery.of(context).size.width * .45,
                    maxWidth: MediaQuery.of(context).size.width * .45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            widget.snapshot.data.results[index].poster_path)),
                    SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      widget.snapshot.data.results[index].title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            SizedBox(
              width: 15,
            )
          ],
        );
      },
    );
  }
}

class MostWatcher extends StatefulWidget {
  AsyncSnapshot<GenreModel> genresSnapshot;

  MostWatcher(this.genresSnapshot);

  @override
  _MostWatcherState createState() => _MostWatcherState();
}

class _MostWatcherState extends State<MostWatcher> {
  @override
  Widget build(BuildContext context) {
    bloc_most_watcher.fetchAllMostWatchMovies();
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 514,
          child: StreamBuilder(
            stream: bloc_most_watcher.allMostWatcherMovies,
            builder: (context, AsyncSnapshot<MovieModel> snapshot) {
              if (snapshot.hasData) {
                return Container(


                  child: McardMostWatcherLoad(snapshot, widget.genresSnapshot),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}

class McardMostWatcherLoad extends StatefulWidget {
  AsyncSnapshot<MovieModel> snapshot;
  AsyncSnapshot<GenreModel> genresSnapshot;

  McardMostWatcherLoad(this.snapshot, this.genresSnapshot);

  @override
  _McardMostWatcherState createState() => _McardMostWatcherState();
}

class _McardMostWatcherState extends State<McardMostWatcherLoad> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 4,
      itemBuilder: (context, int index) {
        String genres = widget.genresSnapshot.data
            .get_genre(widget.snapshot.data.results[index].genre_ids);
        double vote =
            double.parse(widget.snapshot.data.results[index].vote_average);
        Widget starChecker() {
          if (vote >= 5.5 && vote <= 3.6) {
            return Icon(Icons.star_half, color: Colors.greenAccent);
          } else if (vote <= 3.5 && vote >= 0.0) {
            return Icon(Icons.star_border, color: Colors.greenAccent);
          }
          return Icon(
            Icons.star,
            color: Colors.greenAccent,
          );
        }

        return Column(children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Image.network(
                    widget.snapshot.data.results[index].poster_path),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20 - 185,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(
                     top: 20, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Text(
                        widget.snapshot.data.results[index].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      new Text(
                        widget.snapshot.data.results[index].release_date,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      new Text(
                        genres,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          starChecker(),
                          RichText(
                            text: TextSpan(
                                text: widget
                                    .snapshot.data.results[index].vote_average
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' /10',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14))
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 4,
          )
        ]);
      },
    );
  }
}
