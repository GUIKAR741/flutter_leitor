import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/services/notification_service.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../modules/hqs/pages/hq/hq_controller.dart';
import '../../../../shared/models/capitulo_episodio_model.dart';
import '../../../../shared/widgets/card/card_widget.dart';
import '../../../../shared/widgets/drawer/drawer_custom.dart';
import '../../../../shared/widgets/item_lista/item_listagem_titulo.dart';
import '../../../../shared/widgets/pesquisar/pesquisar_capitulo_episodio_widget.dart';

class HqPage extends StatelessWidget {
  final HqController controller = Modular.get<HqController>();

  HqPage({Key key}) : super(key: key);

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
                    rota: '/hqs/ler_hq',
                  ));
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
                            itemCount: capitulos.length + 1,
                            itemBuilder: (_, index) {
                              return index == 0
                                  ? GestureDetector(
                                    onTap: (){
                                      Modular.get<NotificationService>().notificacaoPadrao(mensagem: capitulos[0].titulo);
                                    },
                                                                      child: CardWidget(
                                        titulo: controller.titulo,
                                      ),
                                  )
                                  : ItemListagemTitulo(
                                      capEp: capitulos[index-1],
                                      onPressed: controller.addLista,
                                      rota: '/hqs/ler_hq',
                                    );
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
