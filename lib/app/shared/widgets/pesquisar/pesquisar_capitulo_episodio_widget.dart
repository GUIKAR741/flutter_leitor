import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/animes/pages/anime/anime_controller.dart';
import '../../../shared/controllers/listagem_titulo.dart';
import '../../../shared/models/capitulo_episodio_model.dart';
import '../../../shared/widgets/item_lista/item_listagem_titulo.dart';
import 'pesquisar_widget.dart';

class PesquisarCapituloEpisodio extends Pesquisar {
  final String rota;
  ListagemTitulo controller = Modular.get<ListagemTitulo>();

  PesquisarCapituloEpisodio({
    @required this.rota,
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
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          controller.listarTitulo();
          close(context, '');
        });
  }

  Widget listCapEp() {
    List<CapEpModel> capEp = controller.pesquisar(query);
    return ListView.separated(
      itemCount: capEp.length,
      itemBuilder: (_, index) {
        return ItemListagemTitulo(
          capEp: capEp[index],
          onPressed: controller.addLista,
          rota: rota,
          onLongPress: controller.runtimeType == AnimeController
              ? () async => await (controller as AnimeController).videoExterno(
                    capEp[index],
                  )
              : null,
        );
      },
      separatorBuilder: (_, index) => Divider(),
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
