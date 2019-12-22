import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

import '../../mangas_module.dart';

class LerPage extends StatefulWidget {
  final Titulo manga;
  final Capitulo capitulo;
  const LerPage({Key key, this.manga, this.capitulo}) : super(key: key);

  @override
  _LerPageState createState() => _LerPageState();
}

class _LerPageState extends State<LerPage> {
  LerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MangasModule.to.get<LerBloc>();
    bloc.capitulo = widget.capitulo;
    bloc.listarImagens();
    // bloc.listarCapitulos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.manga.nome} - ${widget.capitulo.titulo}"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: bloc.dados,
            builder: (_, AsyncSnapshot<String> snapshot) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: snapshot.hasData
                          ? ExtendedImage.network(
                              snapshot.data,
                              fit: BoxFit.contain,
                              cache: true,
                              mode: ExtendedImageMode.gesture,
                              initGestureConfigHandler: (state) {
                                return GestureConfig(
                                  minScale: 0.9,
                                  animationMinScale: 0.7,
                                  maxScale: 3.0,
                                  animationMaxScale: 3.5,
                                  speed: 1.0,
                                  inertialSpeed: 100.0,
                                  initialScale: 1.0,
                                  inPageView: false,
                                  initialAlignment: InitialAlignment.center,
                                );
                              },
                              loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.loading:
                                    return Container(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator());
                                    break;
                                  case LoadState.completed:
                                    return state.completedWidget;
                                    break;
                                  case LoadState.failed:
                                    return Container(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                            onTap: () {
                                              state.reLoadImage();
                                            },
                                            child: Text('Erro ao carregar')));
                                    break;
                                }
                                return null;
                              },
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()),
                    ),
                  ]);
            }),
      ),
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Anterior'),
                onPressed: bloc.anterior,
              ),
            ),
            StreamBuilder(
              stream: bloc.pagina,
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : CircularProgressIndicator();
              },
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Proximo'),
                onPressed: bloc.proximo,
              ),
            )
          ]),
    );
  }
}
