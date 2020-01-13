import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_bloc.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';

class AssistirPage extends StatelessWidget {
  final Episodio episodio;
  final AssistirBloc bloc = AssistirModule.to.get<AssistirBloc>();
  AssistirPage({Key key, this.episodio}) : super(key: key);

  @override
  StatelessElement createElement() {
    bloc.iniciarLink(episodio);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: bloc.dados,
          builder: (_, snapshot) {
            return snapshot.hasData? Text(episodio.titulo): Text('Carregando...');
          }
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream: bloc.dados,
                builder: (_, AsyncSnapshot<Chewie> snapshot) {
                  return snapshot.hasData
                      ? snapshot.data
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
