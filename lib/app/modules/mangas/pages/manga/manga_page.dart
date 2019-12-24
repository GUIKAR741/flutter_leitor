import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/widgets/pesquisar/pesquisar_capitulo_widget.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';

class MangaPage extends StatefulWidget {
  final Titulo manga;
  const MangaPage({Key key, this.manga}) : super(key: key);

  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  MangaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MangasModule.to.get<MangaBloc>();
    bloc.manga = widget.manga;
    bloc.listarCapitulos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.manga.nome),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: PesquisarCapitulo(manga: widget.manga));
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
      title: Text(snapshot.data[index].titulo),
      onTap: () {
        Navigator.pushNamed(context, '/mangas/ler_manga', arguments: {
          'manga': widget.manga,
          'capitulo': snapshot.data[index]
        });
      },
    );
  }

  Widget card() {
    return Card(
        child: Row(
      children: <Widget>[
        ExtendedImage.network(
          widget.manga.imagem,
          height: 150,
          width: 100,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Text(
              widget.manga.descricao,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    ));
  }
}
