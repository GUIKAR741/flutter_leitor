import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/widgets/item_lista/item_listagem_titulo.dart';
import 'package:leitor/app/shared/widgets/pesquisar/pesquisar_widget.dart';

class PesquisarCapituloEpisodio extends Pesquisar {
  final String rota;
  final ListagemTitulo controller = Modular.get();

  PesquisarCapituloEpisodio({
    required this.rota,
    searchFieldLabel = 'Pesquisar',
    keyboardType,
    textInputAction = TextInputAction.search,
  }) : super(
            searchFieldLabel: searchFieldLabel,
            keyboardType: keyboardType,
            textInputAction: textInputAction);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          controller.listarTitulo();
          close(context, '');
        });
  }

  Widget listCapEp() {
    List<CapEpModel> capEp = controller.pesquisar(query)!;
    return ListView.separated(
      itemCount: capEp.length,
      itemBuilder: (_, index) {
        return ItemListagemTitulo(
          controller: controller,
          capEp: capEp[index],
          onPressed: controller.addLista,
          rota: rota,
          // onLongPress: controller.runtimeType == AnimeController
          //     ? () async => await (controller as AnimeController).videoExterno(
          //           capEp[index],
          //         )
          //     : null,
        );
      },
      separatorBuilder: (_, index) => const Divider(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return listCapEp();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return super.buildSuggestions(context);
    }
    return listCapEp();
  }
}
