import 'package:flutter/material.dart';

import 'package:themoviedbapp/src/providers/MoviesProvider.dart';
import 'package:themoviedbapp/src/search/SearchDelegate.dart';
import 'package:themoviedbapp/src/widgets/CardSwiperWidget.dart';
import 'package:themoviedbapp/src/widgets/MovieHorizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                  context: context,
                  delegate: DataSearch(),
                  /*query: ""*/
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
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

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text('Populares', style: Theme.of(context).textTheme.subhead),
            padding: EdgeInsets.only(left: 20.0),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){

              if(snapshot.hasData){

                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopulars,
                );

              } else {

                return Center(
                  child: CircularProgressIndicator(),
                );

              }

            },
          )
        ],
      ),
    );
  }

}
