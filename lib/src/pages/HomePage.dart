import 'package:flutter/material.dart';

import 'package:themoviedbapp/src/providers/MoviesProvider.dart';
import 'package:themoviedbapp/src/widgets/CardSwiperWidget.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards()
          ],
        ),
      )
    );

  }

  Widget _swiperCards() {

      return FutureBuilder(
        future: moviesProvider.getOnCinema(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){

          if(snapshot.hasData){

            return CardSwiper(
                movies: snapshot.data
            );

          } else {

           return Container(
             height: 400.0,
             child: Center(
               child: CircularProgressIndicator(),
             ),
           );

          }

        }
      );

  }

}
