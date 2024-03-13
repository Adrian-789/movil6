import 'package:flutter/material.dart';
import 'views/main_screen.dart';
import 'views/gender_prediction_screen.dart';
import 'views/age_prediction_screen.dart';
import 'views/universities_screen.dart';
import 'views/weather_screen.dart';
import 'views/news_screen.dart';
import 'views/about_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/gender_prediction': (context) => GenderPredictionScreen(),
        '/age_prediction': (context) => AgePredictionScreen(),
        '/universities': (context) => UniversitiesScreen(),
        '/weather': (context) => WeatherScreen(),
        '/news': (context) => NewsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
