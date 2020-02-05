import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/widgets/pesquisar/pesquisar_capitulo_widget.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/card/card_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangaPage extends StatelessWidget {
  final TituloModel manga;
  final MangaController controller = Modular.get<MangaController>();

  MangaPage({Key key, this.manga}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.titulo = manga;
    controller.listarTitulo();
    return super.createElement();
  }

  Widget listTile(CapituloModel capitulo) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text(capitulo.titulo),
      subtitle: Text(capitulo.info),
      onTap: () {
        Modular.to.pushNamed('/mangas/ler_manga', arguments: capitulo);
      },
    );
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
              showSearch(context: context, delegate: PesquisarCapitulo());
            },
            tooltip: "Pesquisar",
          ),
          IconButton(
            onPressed: controller.reversed,
            icon: Icon(Icons.swap_vert),
            tooltip: 'Inverter',
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.lista.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<CapituloModel> capitulos = controller.listagem;
          return Column(
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => controller.listarTitulo(),
                  child: capitulos.length > 0
                      ? DraggableScrollbar.semicircle(
                          controller: controller.scroll,
                          child: ListView.separated(
                            controller: controller.scroll,
                            itemCount: capitulos.length,
                            itemBuilder: (_, index) {
                              return index == 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CardWidget(
                                          titulo: manga,
                                        ),
                                        listTile(capitulos[index])
                                      ],
                                    )
                                  : listTile(capitulos[index]);
                            },
                            separatorBuilder: (_, index) => Divider(),
                          ))
                      : Column(
                          children: <Widget>[
                            CardWidget(
                              titulo: manga,
                            ),
                            Center(
                              child: RaisedButton(
                                child: Text("Recarregar"),
                                onPressed: controller.listarTitulo,
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
