import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './ui/homescreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ChalaMovie",
      home: SplashScreen(),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigation() {
    Navigator.push(
        context, new CustomRoute(builder: (context) => new HomeScreen()));
  }

  start() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigation);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarBrightness: Brightness.light));
    return Scaffold(
      body: new Center(
        child: new Image.asset('assets/splash_image/logo_splash.png'),
      ),
    );
  }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    if (settings.isInitialRoute) return child;

    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
