import 'package:flutter/material.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({Key? key}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var imageUrl = 'https://image.tmdb.org/t/p/w500/';

    dynamic movie = ModalRoute.of(context)!.settings.arguments;
    print("selected movie: $movie");
    // print(movie["adult"] ? "For adults" : "for kids");

    if (movie != null) {
      return Scaffold(
        appBar: new AppBar(
          title: new Text("Movie Details"),
        ),
        // body: Center(
        //   child: TextButton(
        //     child: Text("Go back"),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                // Poster and Basic info
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(imageUrl + movie["poster_path"]),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 300,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            movie['title'],
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(8),
                            child: Text(
                              movie['release_date'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "${movie['vote_average']} / 10",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              movie['adult'] ? "For Adults" : "For all age",
                              style: TextStyle(
                                  color: movie['adult']
                                      ? Colors.red
                                      : Colors.green),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Text(movie["overview"]),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Go back",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Text("No data");
    }
  }
}
