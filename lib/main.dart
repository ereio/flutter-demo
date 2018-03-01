import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget generateMovieCard(){
    return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: const Icon(Icons.album),
              title: const Text('The Enchanted Nightingale'),
              subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () { /* ... */ },
                  ),
                  new FlatButton(
                    child: const Text('LISTEN'),
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
        child:  new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemExtent: 132.0,
          itemBuilder: (BuildContext context, int index) {
            return generateMovieCard();
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
