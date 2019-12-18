import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Leitor"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
              child: RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed('/mangas'),
            child: Text("Ler Mangás"),
          )),
          Center(
              child: RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed('/animes'),
            child: Text("Assistir Animes"),
          )),
        ],
      ),
    );
  }
}
