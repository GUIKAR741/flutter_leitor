import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/widgets/pesquisar/pesquisar_capitulo_widget.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangaPage extends StatelessWidget {
  final Titulo manga;
  final MangaBloc bloc;
  MangaPage({Key key, this.manga, this.bloc}) : super(key: key);

  @override
  StatelessElement createElement() {
    bloc.manga = manga;
    bloc.listarCapitulos();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(manga.nome),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: PesquisarCapitulo(manga: manga));
                }),
            IconButton(
              onPressed: bloc.inverterCapitulos,
              icon: Icon(Icons.swap_vert),
            )
          ],
        ),
        body: StreamBuilder(
          stream: bloc.dados,
          builder: (_, AsyncSnapshot<List<Capitulo>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => bloc.listarCapitulos(),
                    child: DraggableScrollbar.semicircle(
                      controller: bloc.scroll,
                      child: ListView.separated(
                        controller: bloc.scroll,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return index == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    card(),
                                    listTile(snapshot, index, context)
                                  ],
                                )
                              : listTile(snapshot, index, context);
                        },
                        separatorBuilder: (_, index) => Divider(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget listTile(snapshot, index, context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text(snapshot.data[index].titulo),
      subtitle: Text(snapshot.data[index].info),
      onTap: () {
        Modular.to.pushNamed('/mangas/ler_manga',
            arguments: {'manga': manga, 'capitulo': snapshot.data[index]});
      },
    );
  }

  Widget card() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ExtendedImage.network(
                  manga.imagem,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blueGrey[700],
          padding: EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Text(
            manga.descricao,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
