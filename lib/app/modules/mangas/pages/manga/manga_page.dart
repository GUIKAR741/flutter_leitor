import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../modules/mangas/pages/manga/manga_controller.dart';
import '../../../../shared/models/capitulo_episodio_model.dart';
import '../../../../shared/widgets/card/card_widget.dart';
import '../../../../shared/widgets/drawer/drawer_custom.dart';
import '../../../../shared/widgets/item_lista/item_listagem_titulo.dart';
import '../../../../shared/widgets/pesquisar/pesquisar_capitulo_episodio_widget.dart';

class MangaPage extends StatelessWidget {
  final MangaController controller = Modular.get<MangaController>();

  MangaPage({Key key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.listarTitulo();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text(controller.titulo.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PesquisarCapituloEpisodio(
                  rota: '/mangas/ler_manga',
                ),
              );
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
          List<CapEpModel> capitulos = controller.listagem;
          return Column(
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => controller.listarTitulo(refresh: true),
                  child: capitulos.length > 0
                      ? ListView.separated(
                          controller: controller.scroll,
                          itemCount: capitulos.length + 1,
                          itemBuilder: (_, index) {
                            return _autoTag(index, capitulos);
                          },
                          separatorBuilder: (_, index) => Divider(),
                        )
                      : Column(
                          children: <Widget>[
                            CardWidget(
                              titulo: controller.titulo,
                            ),
                            Center(
                              child: RaisedButton(
                                child: Text("Recarregar"),
                                onPressed: () =>
                                    controller.listarTitulo(refresh: true),
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

  AutoScrollTag _autoTag(int index, List<CapEpModel> capitulos) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: controller.scroll,
      index: index,
      child: index == 0
          ? CardWidget(
              titulo: controller.titulo,
            )
          : ItemListagemTitulo(
              capEp: capitulos[index - 1],
              onPressed: controller.addLista,
              rota: '/mangas/ler_manga',
            ),
      highlightColor: Colors.black.withOpacity(0.1),
    );
  }
}
