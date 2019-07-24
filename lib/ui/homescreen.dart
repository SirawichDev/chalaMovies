import 'package:flutter/material.dart';
import '../bloc/chala_movies_bloc.dart';
import '../model/movie_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentPage(),
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
    return StreamBuilder(
      stream: bloc.allMovies,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<MovieModel> snapshot) {
        if (snapshot.hasData) {
          return new Container(
            width: 500,
            height: 500,
            color: Colors.pinkAccent.withOpacity(.8),
          );
        } else if (snapshot.hasError) {
          print('Something is wrong');
        } else {
          Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
