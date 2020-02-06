import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/widgets/pesquisar/pesquisar_capitulo_widget.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/card/card_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HqPage extends StatelessWidget {
  final TituloModel hq;
  final HqController controller = Modular.get<HqController>();

  HqPage({Key key, this.hq}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.titulo = hq;
    controller.listarTitulo();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hq.nome),
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
                                          titulo: hq,
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
                              titulo: hq,
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

  Widget listTile(capitulo) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text(capitulo.titulo),
      trailing: Observer(builder: (_) {
        return IconButton(
          icon: Icon(
            capitulo.status ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          tooltip: capitulo.status ? "Lido" : "Não Lido",
          onPressed: () => controller.addLista(capitulo.titulo, capitulo),
        );
      }),
      onTap: () {
        controller.addLista(capitulo.titulo, capitulo, add: true);
        Modular.to.pushNamed('/hqs/ler_hq', arguments: capitulo);
      },
    );
  }
}
