import 'package:flutter/material.dart';
import './model/Movie.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the movie of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hack FSU Demo',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class MovieItem extends StatelessWidget {
  const MovieItem(this.movie);

  final Movie movie;

  Widget _buildTiles(Movie movie) {
    if (movie.title.isNotEmpty)
      return new ListTile(title: new Text(movie.title));
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(movie);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movieList;

  @override
  initState(){
      super.initState();
      _movieList = new List.generate(10, (i) => new Movie("The $i Movie", "It's about the number $i"));
  }

  void _loadMovies(){
    _movieList.add(new Movie("The Revenant", "A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team. "));
    setState(() {
      _movieList = _movieList;
    });
  }

  @override
  Widget buildMovieCard(Movie movie){
    return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.movie),
              title: new Text(movie.title),
              subtitle: new Text(movie.description),
            ),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('SAVE'),
                    onPressed: () { /* ... */ },
                  ),
                  new FlatButton(
                    child: const Text('WATCHED'),
                    onPressed: () { /* ... */ },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
  // Column is also layout widget. It takes a list of children and
  // arranges them vertically. By default, it sizes itself to fit its
  // children horizontally, and tries to be as tall as its parent.

  // Column has various properties to control how it sizes itself and
  // how it positions its children. Here we use mainAxisAlignment to
  // center the children vertically; the main axis here is the vertical
  // axis because Columns are vertical (the cross axis would be
  // horizontal).

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child:  new ListView(
            children: _movieList.map((movie) => buildMovieCard(movie)).toList()
            // padding: new EdgeInsets.all(8.0),
            // itemExtent: 132.0,
            // itemBuilder: (BuildContext context, int index) {
            //   return buildMovieCard(_movieList[index]);
            // },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {_loadMovies();},
        tooltip: 'Load Movies',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
