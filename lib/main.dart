import 'package:flutter/material.dart';
import './model/Movie.dart';

void main() => runApp(new MyApp());

const String appName = "Hack FSU Flutter Demo";

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'SEARCH', icon: Icons.search),
  const Choice(title: 'SAVED', icon: Icons.save),
  const Choice(title: 'WATCHED', icon: Icons.airplay),
];

class MyApp extends StatefulWidget {

  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  final _saved = new Set<Movie>();

  final _watched = new Set<Movie>();

  void toggleSaved(Movie movie) {
    if(_saved.contains(movie)){
      setState(() {_saved.remove(movie);});
    } else {
      setState(() {_saved.add(movie);});
    }
  }

  void toggleWatched(Movie movie) {
    if(_watched.contains(movie)){
      setState(() {_watched.remove(movie);});
    } else {
      setState(() {_watched.add(movie);});
    }
  }

  // This widget is the movie of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appName,
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text(appName),
            bottom: new TabBar(
              tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
                  icon: new Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              switch(choice.title){
                case 'SEARCH':
                  return new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new SearchPage());
                case 'SAVED':
                  return new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new SavedPage(savedMovies: _saved)
                    );
                case 'WATCHED':
                  return new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new WatchedPage(watchedMovies: _saved));
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class WatchedToggler extends StatelessWidget {
  WatchedToggler({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('WATCHED'),
    );
  }
}

Widget buildMovieCard(Movie movie) {
  return new Card(
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.movie),
          title: new Text(movie.title),
          subtitle: new Text(movie.description),
        ),
      ],
    ),
  );
}

Widget buildSearchCard(Movie movie, Function onSaved, Function onWatched) {
  return new Card(
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.movie),
          title: new Text(movie.title),
          subtitle: new Text(movie.description),
        ),
        new ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: new ButtonBar(
            children: <Widget>[
              new FlatButton(
                child: const Text('SAVE'),
                onPressed: () {/* ... */},
              ),
              new FlatButton(
                child: const Text('WATCHED'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Movie> _movieList;

  @override
  initState() {
    super.initState();
    _movieList = new List.generate(
        10, (i) => new Movie("The $i Movie", "It's about the number $i"));
  }

  void _searchMovies() {
    setState(() {
      _movieList.clear();
      _movieList.add(new Movie("The Revenant",
          "A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team. ")); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new ListView(
            children: _movieList.map((movie) => buildMovieCard(movie)).toList()
            // padding: new EdgeInsets.all(8.0),
            // itemExtent: 132.0,
            // itemBuilder: (BuildContext context, int index) {
            //   return buildMovieCard(_movieList[index]);
            // },
            ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _searchMovies();
        },
        tooltip: 'Search Movies',
        child: new Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class SavedPage extends StatelessWidget {
  SavedPage({this.savedMovies}) : super();

  final Set<Movie> savedMovies;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new ListView(
            children: savedMovies.map((movie) => buildMovieCard(movie)).toList()
            // padding: new EdgeInsets.all(8.0),
            // itemExtent: 132.0,
            // itemBuilder: (BuildContext context, int index) {
            //   return buildMovieCard(_movieList[index]);
            // },
            ),
      ),
    );
  }
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class WatchedPage extends StatelessWidget {
  WatchedPage({this.watchedMovies}) : super();

  final Set<Movie> watchedMovies;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new ListView(
            children: watchedMovies.map((movie) => buildMovieCard(movie)).toList()
            // padding: new EdgeInsets.all(8.0),
            // itemExtent: 132.0,
            // itemBuilder: (BuildContext context, int index) {
            //   return buildMovieCard(_movieList[index]);
            // },
            ),
      ),
    );
  }
}
