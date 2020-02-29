import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../modules/mangas/pages/manga/manga_controller.dart';
import '../../../../modules/mangas/widgets/pesquisar/pesquisar_capitulo_widget.dart';
import '../../../../shared/models/capitulo_episodio_model.dart';
import '../../../../shared/widgets/card/card_widget.dart';
import '../../../../shared/widgets/drawer/drawer_custom.dart';

class MangaPage extends StatelessWidget {
  final MangaController controller = Modular.get<MangaController>();

  MangaPage({Key key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.listarTitulo();
    return super.createElement();
  }

  Widget listTile(CapEpModel capitulo) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text(capitulo.titulo),
      subtitle: Text(capitulo.info),
      trailing: Observer(
        builder: (_) {
          return IconButton(
            icon: Icon(
              capitulo.status ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            tooltip: capitulo.status ? "Lido" : "Não Lido",
            onPressed: () => controller.addLista(capitulo.titulo, capitulo),
          );
        },
      ),
      onTap: () {
        controller.addLista(capitulo.titulo, capitulo, add: true);
        Modular.to.pushNamed('/mangas/ler_manga', arguments: capitulo);
      },
    );
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
          List<CapEpModel> capitulos = controller.listagem;
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
                                          titulo: controller.titulo,
                                        ),
                                        listTile(capitulos[index])
                                      ],
                                    )
                                  : listTile(capitulos[index]);
                            },
                            separatorBuilder: (_, index) => Divider(),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            CardWidget(
                              titulo: controller.titulo,
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
