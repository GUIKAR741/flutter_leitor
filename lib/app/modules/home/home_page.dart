import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_bloc.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  final String title;
  final AppBloc bloc = AppModule.to.get<AppBloc>();

  HomePage({Key key, this.title = "Leitor"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          StreamBuilder(
              stream: bloc.tema,
              builder: (context, snapshot) {
                IconData icone = snapshot.hasData
                    ? (snapshot.data ? Icons.brightness_7 : Icons.brightness_3)
                    : Icons.brightness_7;
                return IconButton(
                  icon: Icon(icone),
                  onPressed: bloc.mudarTema,
                );
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Modular.to.pushNamed('/hqs'),
              child: Text("Ler HQs"),
            ),
            RaisedButton(
              onPressed: () => Modular.to.pushNamed('/mangas'),
              child: Text("Ler Mangás"),
            ),
            RaisedButton(
              onPressed: () => Modular.to.pushNamed('/animes'),
              child: Text("Assistir Animes"),
            ),
          ],
        ),
      ),
    );
  }
}
