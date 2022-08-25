import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/modules/mangas/pages/mangas/mangas_store.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/widgets/drawer/drawer_custom.dart';
import 'package:leitor/app/shared/widgets/item_lista/item_listagem_principal.dart';
import 'package:leitor/app/shared/widgets/pesquisar/pesquisar_titulo_widget.dart';

class MangasPage extends StatefulWidget {
  final String title;

  const MangasPage({
    Key? key,
    this.title = "Mangas",
  }) : super(key: key);

  @override
  State<MangasPage> createState() => MangasPageState();
}

class MangasPageState extends State<MangasPage> {
  final MangasStore controller = Modular.get();

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
                  rota: '/mangas/manga',
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
                          rota: '/mangas/manga',
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
