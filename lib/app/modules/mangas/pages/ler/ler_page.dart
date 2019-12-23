import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/widgets/pagina_manga/pagina_manga_widget.dart';
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

  Widget mostrarPaginas() {
    return StreamBuilder(
      stream: bloc.pagina,
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  snapshot.data,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.manga.nome} - ${widget.capitulo.titulo}"),
        actions: <Widget>[
          Center(
            child: mostrarPaginas(),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: bloc.dados,
            builder: (_, AsyncSnapshot<List<PaginaMangaWidget>> snapshot) {
              return snapshot.hasData
                  ? PageView(
                      onPageChanged: bloc.mudar,
                      children: snapshot.data,
                    )
                  : CircularProgressIndicator();
            }),
      ),
    );
  }
}
