import 'package:flutter/material.dart';
import 'package:movies_list_1/screens/movie_details_page.dart';
import 'package:movies_list_1/screens/movie_list_page.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "Movie List",
        // home: MovieListPage(),
        initialRoute: "/",
        routes: {
          "/": (context) => MovieListPage(),
          "/movieDetails": (context) => MovieDetailsPage(),
        },
      ),
    );
  }
}