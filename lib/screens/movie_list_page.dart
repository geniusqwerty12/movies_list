import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MovieListPage extends StatefulWidget {
  MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  var imageUrl = 'https://image.tmdb.org/t/p/w500/';

  // API key from the service
  // Note that this should not be embedded directly in your code, as much as possible hide this
  final apiKey = "7feb11c2a5e8158a9168d88ae75dc0b4";

  var movies;
  bool? isLoading;

  Future getMovieList() async {
    // call the method to get the results
    setState(() {
      isLoading = true;
    });
    var data = await getMoviesJSON();
    // you can check the raw content
    // print(data);
    // update the movie list in the state
    setState(() {
      isLoading = false;
      movies = data['results'];
    });
  }

  Future<Map> getMoviesJSON() async {
    // Add an artificial delay to show the loading indicator
    // await Future.delayed(Duration(seconds: 3), () {});

    // The API I used is from the movie db, see here: https://developer.themoviedb.org/docs/getting-started
    // it gives you access to the list of current movies
    // you can get your API key by registering to said service
    var apiKey = "7feb11c2a5e8158a9168d88ae75dc0b4";
    // parsing the string, with the key parameter to an URL
    var url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey');
    var response = await http.get(url);
    // Most of the time we need to decode JSON results
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch the movies from the API at the start
    // Don't use if you are using a FutureBuilder
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Movie List'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Text(
                  "Discover the latet movies",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18,
                  ),
                )),
            FutureBuilder(
              future: getMoviesJSON(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  // print(snapshot.data);
                  // retrieve the list from the response
                  var data = snapshot.data as Map;
                  var results = data['results'];
                  print(results);

                  return Expanded(
                    child: ListView.builder(
                        itemCount: results == null ? 0 : results.length,
                        itemBuilder: (context, i) {
                          return new MaterialButton(
                            child: new Card(
                              child: ListTile(
                                leading: Image(
                                    image: new NetworkImage(
                                        imageUrl + results[i]["poster_path"])),
                                title: new Text(results[i]['title']),
                                subtitle: Text(results[i]["release_date"]),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/movieDetails",
                                  arguments: results[i]);
                            },
                          );
                        }),
                  );
                }

                if (snapshot.hasError) {
                  return Text(
                      "An error has occured: ${snapshot.error.toString()}");
                }

                return Container();
              },
            ),

            // child: isLoading!
            //     ? Center(child: CircularProgressIndicator())
            //     : ListView.builder(
            //         itemCount: movies == null ? 0 : movies.length,
            //         itemBuilder: (context, i) {
            //           return new MaterialButton(
            //             child: new Card(
            //               child: ListTile(
            //                 leading: Image(
            //                     image: new NetworkImage(
            //                         imageUrl + movies[i]["poster_path"])),
            //                 title: new Text(movies[i]['title']),
            //                 subtitle: Text(movies[i]["release_date"]),
            //               ),
            //             ),
            //             onPressed: () {
            //               Navigator.pushNamed(context, "/movieDetails",
            //                   arguments: movies[i]);
            //             },
            //           );
            //         }),
          ],
        ),
      ),
    );
  }
}
