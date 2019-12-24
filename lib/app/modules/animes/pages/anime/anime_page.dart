import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/widgets/pesquisar/pesquisar_episodio_widget.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class AnimePage extends StatefulWidget {
  final Titulo anime;
  const AnimePage({Key key, this.anime}) : super(key: key);

  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  AnimeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AnimesModule.to.get<AnimeBloc>();
    bloc.anime = widget.anime;
    bloc.listarEpisodios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.anime.nome),
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
                                    listTile(snapshot, index)
                                  ],
                                )
                              : listTile(snapshot, index);
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

  Widget listTile(snapshot, index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      leading: Container(
        height: 100,
        width: 70,
        child: ExtendedImage.network(snapshot.data[index].imagem,
            cache: true, fit: BoxFit.fill),
      ),
      title: Text(snapshot.data[index].titulo),
      subtitle: Text(snapshot.data[index].info),
      onTap: () => bloc.mudarPagina(context, snapshot.data[index]),
    );
  }

  Widget card() {
    return Card(
        child: Row(
      children: <Widget>[
        ExtendedImage.network(
          widget.anime.imagem,
          height: 150,
          width: 100,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  widget.anime.descricao,
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
