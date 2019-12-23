import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_bloc.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';

class AssistirPage extends StatefulWidget {
  final Episodio episodio;
  const AssistirPage({Key key, this.episodio}) : super(key: key);

  @override
  _AssistirPageState createState() => _AssistirPageState();
}

class _AssistirPageState extends State<AssistirPage> {
  AssistirBloc bloc = AssistirModule.to.get<AssistirBloc>();

  @override
  void initState() {
    super.initState();
    bloc.iniciarLink(widget.episodio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episodio.titulo),
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
