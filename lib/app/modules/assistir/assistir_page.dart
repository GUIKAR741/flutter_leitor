import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_controller.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssistirPage extends StatelessWidget {
  final EpisodioModel episodio;
  final AssistirController controller = Modular.get<AssistirController>();
  AssistirPage({Key key, this.episodio}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.iniciarLink(episodio);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return controller.chewie.value != null
              ? Text(episodio.titulo)
              : Text('Carregando...');
        }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Observer(
                builder: (_) {
                  return controller.chewie.value != null
                      ? controller.chewie.value
                      : CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
