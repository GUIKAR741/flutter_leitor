import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preload_page_view/preload_page_view.dart';

class LerPage extends StatelessWidget {
  final Capitulo capitulo;
  final LerBloc bloc = Modular.get<LerBloc>();

  LerPage({Key key, this.capitulo}) : super(key: key);

  @override
  StatelessElement createElement() {
    bloc.capitulo = capitulo;
    bloc.listarImagens();
    return super.createElement();
  }

  Widget mostrarPaginas() {
    return StreamBuilder(
      stream: bloc.pagina,
      builder: (_, snapshot) {
        return snapshot.hasData
            ? MudarPaginaWidget(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    snapshot.data,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onChanged: bloc.escrever,
                onPressed: bloc.irPara,
              )
            : Padding(
                padding: EdgeInsets.only(right: 20),
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitulo.titulo),
        actions: <Widget>[
          Center(
            child: mostrarPaginas(),
          ),
          StreamBuilder<Object>(
            stream: bloc.icon,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(snapshot.data),
                onPressed: bloc.pausar,
                tooltip: "Play/Pause",
              );
            }
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: bloc.dados,
            builder: (_, AsyncSnapshot<List<PaginaImagemWidget>> snapshot) {
              return snapshot.hasData
                  ? PreloadPageView(
                      controller: bloc.pageController,
                      onPageChanged: bloc.paginacao ? bloc.mudar : null,
                      children: snapshot.data,
                      preloadPagesCount: 5,
                    )
                  : CircularProgressIndicator();
            }),
      ),
    );
  }
}
