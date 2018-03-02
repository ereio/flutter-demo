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

typedef void MovieVoidCallback(Movie movie);
typedef bool MovieBoolCallback(Movie movie);

class MyAppState extends State<MyApp> {
  final _saved = new Set<Movie>();
  final _watched = new Set<Movie>();

  SearchPage _searchPage;

  void toggleSaved(Movie movie) {
    if (_saved.contains(movie)) {
      setState(() {
        _saved.remove(movie);
      });
    } else {
      setState(() {
        _saved.add(movie);
      });
    }
  }

  void toggleWatched(Movie movie) {
    if (_watched.contains(movie)) {
      setState(() {
        _watched.remove(movie);
      });
    } else {
      setState(() {
        _watched.add(movie);
      });
    }
  }

  bool isWatched(Movie movie) {
    return _watched.contains(movie);
  }

  bool isSaved(Movie movie) {
    return _saved.contains(movie);
  }

  @override
  initState() {
    super.initState();
    _searchPage = new SearchPage(
      toggleWatched: toggleWatched,
      toggleSaved: toggleSaved,
      isSaved: isSaved,
      isWatched: isWatched,
    );
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
              switch (choice.title) {
                case 'SEARCH':
                  return new Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: new SearchPage(
                      toggleWatched: toggleWatched,
                      toggleSaved: toggleSaved,
                      isSaved: isSaved,
                      isWatched: isWatched,
                    ),
                  );
                case 'SAVED':
                  return new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new SavedPage(savedMovies: _saved));
                case 'WATCHED':
                  return new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new WatchedPage(watchedMovies: _watched));
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}

Widget buildMovieCard(Movie movie) {
  return new Card(
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Image.network(
          movie.posterUrl,
          width: 600.0,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new ListTile(
          leading: const Icon(Icons.movie),
          title: new Text(movie.title),
          subtitle: new Text(movie.description),
        ),
      ],
    ),
  );
}

class SearchMovieCard extends StatelessWidget {
  SearchMovieCard(
      {Key key,
      Movie movie,
      this.toggleSaved,
      this.toggleWatched,
      this.isSaved,
      this.isWatched})
      : movie = movie,
        super(key: key);

  final Movie movie;

  // Result is simply handed off to SearchMovieCard as bool
  final bool isSaved;
  final bool isWatched;

  // Passing Objects all the way down in case they need to be modified locally
  final MovieVoidCallback toggleSaved;
  final MovieVoidCallback toggleWatched;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.network(
            movie.posterUrl,
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
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
                  child: isSaved ? const Text('UNSAVE') : const Text('SAVE'),
                  onPressed: () {
                    toggleSaved(movie);
                  },
                ),
                new FlatButton(
                  child: isWatched
                      ? const Text('UNWATCHED')
                      : const Text('WATCHED'),
                  onPressed: () {
                    toggleWatched(movie);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class SearchPage extends StatefulWidget {
  SearchPage(
      {Key key,
      this.isSaved,
      this.isWatched,
      this.toggleWatched,
      this.toggleSaved})
      : super(key: key);

  final MovieBoolCallback isSaved;
  final MovieBoolCallback isWatched;
  final MovieVoidCallback toggleSaved;
  final MovieVoidCallback toggleWatched;

  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Movie> _movieList;

  @override
  initState() {
    super.initState();
    _movieList = new List.generate(
        10,
        (i) => new Movie("The $i Movie", "It's about the number $i",
            'http://www.doctormacro.com/Images/Posters/A/Poster%20-%20Abraham%20Lincoln%20(1930)_01.jpg'));
  }

  void _searchMovies() {
    setState(() {
      _movieList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new ListView(
            children: _movieList
                .map((movie) => new SearchMovieCard(
                      movie: movie,
                      isSaved: widget.isSaved(movie),
                      isWatched: widget.isWatched(movie),
                      toggleSaved: widget.toggleSaved,
                      toggleWatched: widget.toggleWatched,
                    ))
                .toList()),
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
            children:
                savedMovies.map((movie) => buildMovieCard(movie)).toList()),
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
            children:
                watchedMovies.map((movie) => buildMovieCard(movie)).toList()),
      ),
    );
  }
}
