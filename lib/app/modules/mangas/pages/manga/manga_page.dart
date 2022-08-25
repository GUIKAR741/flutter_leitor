import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/modules/mangas/pages/manga/manga_store.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/widgets/card/card_widget.dart';
import 'package:leitor/app/shared/widgets/drawer/drawer_custom.dart';
import 'package:leitor/app/shared/widgets/item_lista/item_listagem_titulo.dart';
import 'package:leitor/app/shared/widgets/pesquisar/pesquisar_capitulo_episodio_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MangaPage> createState() => MangaPageState();
}

class MangaPageState extends State<MangaPage> {
  final MangaStore controller = Modular.get();

  @override
  void initState() {
    super.initState();
    controller.listarTitulo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text(controller.titulo!.nome!),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
            icon: const Icon(Icons.swap_vert),
            tooltip: 'Inverter',
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.lista?.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          List<CapEpModel> capitulos = controller.listagem!;
          return Column(
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => controller.listarTitulo(refresh: true),
                  child: capitulos.isNotEmpty
                      ? ListView.separated(
                          controller: controller.scroll,
                          itemCount: capitulos.length + 1,
                          itemBuilder: (_, index) {
                            return _autoTag(index, capitulos);
                          },
                          separatorBuilder: (_, index) => const Divider(),
                        )
                      : Column(
                          children: <Widget>[
                            CardWidget(
                              titulo: controller.titulo!,
                            ),
                            Center(
                              child: ElevatedButton(
                                child: const Text("Recarregar"),
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
      highlightColor: Colors.black.withOpacity(0.1),
      child: index == 0
          ? CardWidget(
              titulo: controller.titulo!,
            )
          : ItemListagemTitulo(
              controller: controller,
              capEp: capitulos[index - 1],
              onPressed: controller.addLista,
              rota: '/mangas/ler_manga',
            ),
    );
  }
}
