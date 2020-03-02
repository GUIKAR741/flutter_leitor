import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/hqs/hqs_controller.dart';
import '../../shared/models/titulo_model.dart';
import '../../shared/widgets/drawer/drawer_custom.dart';
import '../../shared/widgets/item_lista/item_listagem_principal.dart';
import '../../shared/widgets/pesquisar/pesquisar_titulo_widget.dart';

class HqsPage extends StatelessWidget {
  final String title;
  final HqsController controller = Modular.get<HqsController>();

  HqsPage({Key key, this.title = "HQs"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PesquisarTitulo(
                  rota: '/hqs/hq',
                ),
              );
            },
            tooltip: "Pesquisar",
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.titulos.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<TituloModel> titulos = controller.titulos.value;
          return RefreshIndicator(
            onRefresh: () async {
              controller.listar(refresh: true);
            },
            child: titulos.length > 0
                ? Scrollbar(
                    controller: controller.scroll,
                    child: ListView.separated(
                      controller: controller.scroll,
                      itemCount: titulos.length,
                      itemBuilder: (_, index) {
                        return ItemListagemPrincipal(
                          titulo: titulos[index],
                          onPressed: controller.addFavorito,
                          rota: '/hqs/hq',
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                    ),
                  )
                : Center(
                    child: RaisedButton(
                      child: Text("Recarregar Titulos"),
                      onPressed: () => controller.listar(refresh: true),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
