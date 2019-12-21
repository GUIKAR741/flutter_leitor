import 'package:flutter/material.dart';

class LerPage extends StatefulWidget {
  final String title;
  const LerPage({Key key, this.title = "Ler"}) : super(key: key);

  @override
  _LerPageState createState() => _LerPageState();
}

class _LerPageState extends State<LerPage> {
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
