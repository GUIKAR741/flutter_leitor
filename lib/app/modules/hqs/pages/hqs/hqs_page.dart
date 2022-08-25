import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/modules/hqs/pages/hqs/hqs_store.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/widgets/drawer/drawer_custom.dart';
import 'package:leitor/app/shared/widgets/item_lista/item_listagem_principal.dart';
import 'package:leitor/app/shared/widgets/pesquisar/pesquisar_titulo_widget.dart';

class HqsPage extends StatefulWidget {
  final String title;

  const HqsPage({Key? key, this.title = 'HQs'}) : super(key: key);

  @override
  State<HqsPage> createState() => HqsPageState();
}

class HqsPageState extends State<HqsPage> {
  final HqsStore controller = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
          if (controller.titulos?.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          List<TituloModel> titulos = controller.titulos!.value!;
          return RefreshIndicator(
            onRefresh: () async {
              controller.listar(refresh: true);
            },
            child: titulos.isNotEmpty
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
                      separatorBuilder: (_, index) => const Divider(),
                    ),
                  )
                : Center(
                    child: ElevatedButton(
                      child: const Text("Recarregar Titulos"),
                      onPressed: () => controller.listar(refresh: true),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
