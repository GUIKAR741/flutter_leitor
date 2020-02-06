import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  final String title;
  final AppController controller = Modular.get<AppController>();

  HomePage({Key key, this.title = "Leitor"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            tooltip: "Limpar Imagens",
            onPressed: () {
              clearDiskCachedImages();
              clearMemoryImageCache();
            },
          ),
          Observer(
            builder: (_) {
              IconData icone =
                  (controller.tema ? Icons.brightness_7 : Icons.brightness_3);
              return IconButton(
                tooltip: "Mudar Tema",
                icon: Icon(icone),
                onPressed: controller.mudarTema,
              );
            },
          )
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
