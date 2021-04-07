import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_list_1/screens/movie_details_page.dart';

import 'package:http/http.dart' as http;

class MovieListPage extends StatefulWidget {
  MovieListPage({Key key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {

  var imageUrl = 'https://image.tmdb.org/t/p/w500/';

  var movies;

  Future getMovieList() async {
    var data = await getMoviesJSON();
    setState(() {
        movies = data['results']; 
    });
  }

    // Use static data first
  // List movies = [
  //   	{
  //       "adult":false,
  //       "backdrop_path":"/pcDc2WJAYGJTTvRSEIpRZwM3Ola.jpg",
  //       "genre_ids":[28,12,14,878],
  //       "id":791373,
  //       "original_language":"en",
  //       "original_title":"Zack Snyder's Justice League",
  //       "overview":"Determined to ensure Superman's ultimate sacrifice was not in vain, Bruce Wayne aligns forces with Diana Prince with plans to recruit a team of metahumans to protect the world from an approaching threat of catastrophic proportions.",
  //       "popularity":7753.517,
  //       "poster_path":"/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg",
  //       "release_date":"2021-03-18",
  //       "title":"Zack Snyder's Justice League",
  //       "video":false,
  //       "vote_average":8.6,
  //       "vote_count":4247
  //     },
  //     {
  //       "adult":false,
  //       "backdrop_path":"/9xeEGUZjgiKlI69jwIOi0hjKUIk.jpg",
  //       "genre_ids":[16,28,14],"id":664767,
  //       "original_language":"en",
  //       "original_title":"Mortal Kombat Legends: Scorpion's Revenge",
  //       "overview":"After the vicious slaughter of his family by stone-cold mercenary Sub-Zero, Hanzo Hasashi is exiled to the torturous Netherrealm. There, in exchange for his servitude to the sinister Quan Chi, he’s given a chance to avenge his family – and is resurrected as Scorpion, a lost soul bent on revenge. Back on Earthrealm, Lord Raiden gathers a team of elite warriors – Shaolin monk Liu Kang, Special Forces officer Sonya Blade and action star Johnny Cage – an unlikely band of heroes with one chance to save humanity. To do this, they must defeat Shang Tsung’s horde of Outworld gladiators and reign over the Mortal Kombat tournament.",
  //       "popularity":1043.322,
  //       "poster_path":"/4VlXER3FImHeFuUjBShFamhIp9M.jpg",
  //       "release_date":"2020-04-12",
  //       "title":"Mortal Kombat Legends: Scorpion's Revenge",
  //       "video":false,
  //       "vote_average":8.4,
  //       "vote_count":818
  //     },

  //     {
  //       "adult":false,
  //       "backdrop_path":"/cjaOSjsjV6cl3uXdJqimktT880L.jpg",
  //       "genre_ids":[10751,14,16,35],"id":529203,"original_language":"en",
  //       "original_title":"The Croods: A New Age",
  //       "overview":"Searching for a safer habitat, the prehistoric Crood family discovers an idyllic, walled-in paradise that meets all of its needs. Unfortunately, they must also learn to live with the Bettermans -- a family that's a couple of steps above the Croods on the evolutionary ladder. As tensions between the new neighbors start to rise, a new threat soon propels both clans on an epic adventure that forces them to embrace their differences, draw strength from one another, and survive together.",
  //       "popularity":942.767,
  //       "poster_path":"/tbVZ3Sq88dZaCANlUcewQuHQOaE.jpg",
  //       "release_date":"2020-11-25",
  //       "title":"The Croods: A New Age",
  //       "video":false,
  //       "vote_average":7.5,
  //       "vote_count":1862
  //     }
  // ];

  @override
  Widget build(BuildContext context) {
    getMovieList();

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Movies'),
      ),
      // body: Center(
      //   child: TextButton(
      //     child: Text("Go to next page"),
      //     onPressed: () {
      //       Navigator.push(context, 
      //       new MaterialPageRoute(
      //         builder: (context) => new MovieDetailsPage(),
      //       ));
      //     },
      //   ),
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
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: movies == null ? 0 : movies.length,
                itemBuilder: (context, i) {
                  return new MaterialButton(
                    child: new Card(
                      child: ListTile(
                        leading: Image(
                          image: new NetworkImage(imageUrl + movies[i]["poster_path"])
                        ),
                        title: new Text(movies[i]['title']),
                        subtitle: Text(movies[i]["release_date"]),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context, 
                        "/movieDetails",
                        arguments: movies[i]
                      );
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getMoviesJSON() async {
  var apiKey = "7feb11c2a5e8158a9168d88ae75dc0b4";
  var url = Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=$apiKey');
  var response = await http.get(url);
  return jsonDecode(response.body);
}