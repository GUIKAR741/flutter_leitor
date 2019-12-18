import 'package:flutter/material.dart';

class MangasPage extends StatefulWidget {
  final String title;
  const MangasPage({Key key, this.title = "Mangas"}) : super(key: key);

  @override
  _MangasPageState createState() => _MangasPageState();
}

class _MangasPageState extends State<MangasPage> {
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
