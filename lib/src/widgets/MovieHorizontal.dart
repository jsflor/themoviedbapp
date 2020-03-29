import 'package:flutter/material.dart';

import 'package:themoviedbapp/src/models/MovieModel.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) => _card(context, movies[index])
      ),
    );

  }

  Widget _card(BuildContext context, Movie m){

    final card =  Container(
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

    return GestureDetector(
      child: card,
      onTap: (){
          Navigator.pushNamed(context, 'detail', arguments: m);
      },
    );

  }

  /*List<Widget> _cards(BuildContext context) {

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

  }*/

}
