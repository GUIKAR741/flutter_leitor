import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/widgets/pesquisar/pesquisar_episodio_widget.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class AnimePage extends StatelessWidget {
  final Titulo anime;
  final AnimeBloc bloc;
  const AnimePage({Key key, this.anime, this.bloc}) : super(key: key);

  @override
  StatelessElement createElement() {
    bloc.anime = anime;
    bloc.listarEpisodios();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(anime.nome),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: PesquisarEpisodio());
                }),
            IconButton(
              onPressed: bloc.inverterEpisodios,
              icon: Icon(Icons.swap_vert),
            )
          ],
        ),
        body: StreamBuilder(
          stream: bloc.dados,
          builder: (_, AsyncSnapshot<List<Episodio>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => bloc.listarEpisodios(),
                    child: DraggableScrollbar.semicircle(
                      controller: bloc.scrollController,
                      child: ListView.separated(
                        controller: bloc.scrollController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return index == 0
                              ? Column(
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
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        height: 100,
        width: 70,
        child: ExtendedImage.network(snapshot.data[index].imagem,
            cache: true, fit: BoxFit.fill),
      ),
      title: Text(snapshot.data[index].titulo),
      subtitle: Text(snapshot.data[index].info),
      onTap: () => bloc.mudarPagina(snapshot.data[index]),
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
                  anime.imagem,
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
            anime.descricao,
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
