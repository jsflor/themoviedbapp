import 'package:flutter/material.dart';

import 'package:themoviedbapp/src/pages/HomePage.dart';
import 'package:themoviedbapp/src/pages/MovieDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Movie DB',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail()
      },
    );
  }
}
