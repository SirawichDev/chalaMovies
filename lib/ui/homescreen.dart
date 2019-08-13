import 'package:chalaMovie/bloc/chala_most_watch_movies_bloc.dart';
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
        bgHeight = max(0, 300.0 - _controller.offset);
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
        children: <Widget>[ContentPage()],
      ),
    );
  }
}

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 20),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height + 100,
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
              MostWatcher()
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
            width: MediaQuery
                .of(context)
                .size
                .width - 20,
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
      itemCount: widget.snapshot.data.results.length,
      itemBuilder: (context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ConstrainedBox(
                constraints: new BoxConstraints(
                    maxHeight: 290.0,
                    minHeight: 190.0,
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width * .45,
                    maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width * .45),
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
  @override
  _MostWatcherState createState() => _MostWatcherState();
}


class _MostWatcherState extends State<MostWatcher> {
  @override
  Widget build(BuildContext context) {
    bloc_most_watcher.fetchAllMostWatchMovies();
    return Expanded(
      child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height - 20,
          child: StreamBuilder(
            stream: bloc_most_watcher.allMostWatcherMovies,
            builder: (context, AsyncSnapshot<MovieModel> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,

                  child: McardMostWatcherLoad(snapshot),
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

  McardMostWatcherLoad(this.snapshot);

  @override
  _McardMostWatcherState createState() => _McardMostWatcherState();
}

class _McardMostWatcherState extends State<McardMostWatcherLoad> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.snapshot.data.results.length,
      itemBuilder: (context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    widget.snapshot.data.results[index].poster_path)),
            SizedBox(
              width: 15,
            )
          ],
        );
      },
    );
  }

}