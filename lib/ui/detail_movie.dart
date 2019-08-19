import 'package:chalaMovie/model/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDeeperDetais extends StatefulWidget {
  Result data;

  MovieDeeperDetais(this.data);

  @override
  _MovieDeeperDetaisState createState() => _MovieDeeperDetaisState();
}

class _MovieDeeperDetaisState extends State<MovieDeeperDetais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentPage(widget.data),
    );
  }
}

class ContentPage extends StatefulWidget {
  Result data;

  ContentPage(this.data);

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
            height: 360,
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
              padding: EdgeInsets.only(left: 20,top: 8),
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.1, 0.3, .5, .7, .9],
                      colors: [Colors.black, Colors.black.withOpacity(1),
                        Colors.black.withOpacity(.01),
                        Colors.black.withOpacity(.3),
                        Colors.black.withOpacity(.6),
                        Colors.black.withOpacity(.9),
                        Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          )
        ],
      ),
    );
  }
}
