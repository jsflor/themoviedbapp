import 'package:flutter/material.dart';

import 'package:themoviedbapp/src/models/MovieModel.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  MovieHorizontal({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _cards(context)
      ),
    );

  }

  List<Widget> _cards(BuildContext context) {

    return movies.map((m){

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(m.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 110.0,
                width: 140.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              m.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

    }).toList();

  }

}
