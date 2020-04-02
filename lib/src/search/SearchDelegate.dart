import 'package:flutter/material.dart';
import 'package:themoviedbapp/src/models/MovieModel.dart';
import 'package:themoviedbapp/src/providers/MoviesProvider.dart';

class DataSearch extends SearchDelegate {

  String selection = "";
  final moviesProvider = new MoviesProvider();

  final movies = [
    "Spiderman",
    "Captain America",
    "Spiderman",
    "Captain America",
    "Spiderman",
    "Captain America",
    "Spiderman",
    "Captain America",
  ];

  final recentMovies = [
    "Spiderman",
    "Captain America"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {

    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){

        if(snapshot.hasData){

          final movies = snapshot.data;

          return ListView(
            children: movies.map((m){
              return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(m.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                title: Text(m.title),
                subtitle: Text(m.originalTitle),
                onTap: (){
                    close(context, null);
                    m.uniqueId = "";
                    Navigator.pushNamed(context, 'detail', arguments: m);
                }
              );
            }).toList(),
          );

        } else {

          return Center(
            child: CircularProgressIndicator(),
          );

        }

      },
    );

  }



}