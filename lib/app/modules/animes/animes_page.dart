import 'package:flutter/material.dart';

class AnimesPage extends StatefulWidget {
  final String title;
  const AnimesPage({Key key, this.title = "Animes"}) : super(key: key);

  @override
  _AnimesPageState createState() => _AnimesPageState();
}

class _AnimesPageState extends State<AnimesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
