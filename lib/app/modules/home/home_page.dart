import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_bloc.dart';
import 'package:flutter_leitor/app/app_module.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Leitor"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBloc bloc = AppModule.to.get<AppBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          StreamBuilder(
            stream: bloc.tema,
            builder: (context, snapshot) {
              IconData icone = snapshot.hasData ? (snapshot.data ? Icons.brightness_7 : Icons.brightness_3) : Icons.brightness_7;
              return IconButton(
                icon: Icon(icone),
                onPressed: bloc.mudarTema,
              );
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/mangas'),
              child: Text("Ler Mangás"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/animes'),
              child: Text("Assistir Animes"),
            ),
          ],
        ),
      ),
    );
  }
}
