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

class MyApp extends StatelessWidget {
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
                      child: new SearchPage());
                case 'WATCHED':
                  return new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new SearchPage());
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;

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

  void _loadMovies() {
    _movieList.add(new Movie("The Revenant",
        "A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team. "));
    setState(() {
      _movieList = _movieList;
    });
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
          _loadMovies();
        },
        tooltip: 'Load Movies',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class SavedPage extends StatefulWidget {
  SavedPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SavedPageState createState() => new SavedPageState();
}

class SavedPageState extends State<SearchPage> {
  List<Movie> _movieList;

  @override
  initState() {
    super.initState();
    _movieList = new List.generate(
        10, (i) => new Movie("The $i Movie", "It's about the number $i"));
  }

  void _loadMovies() {
    _movieList.add(new Movie("The Revenant",
        "A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team. "));
    setState(() {
      _movieList = _movieList;
    });
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
    );
  }
}

// home: new MyHomePage(title: 'Hack FSU Flutter Demo'),
class WatchedPage extends StatefulWidget {
  WatchedPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WatchedPageState createState() => new WatchedPageState();
}

class WatchedPageState extends State<SearchPage> {
  List<Movie> _movieList;

  @override
  initState() {
    super.initState();
    _movieList = new List.generate(
        10, (i) => new Movie("The $i Movie", "It's about the number $i"));
  }

  void _loadMovies() {
    _movieList.add(new Movie("The Revenant",
        "A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team. "));
    setState(() {
      _movieList = _movieList;
    });
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
          _loadMovies();
        },
        tooltip: 'Load Movies',
        child: new Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
