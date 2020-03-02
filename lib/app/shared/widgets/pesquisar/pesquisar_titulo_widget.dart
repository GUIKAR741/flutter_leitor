import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controllers/listagem_principal.dart';
import '../../models/titulo_model.dart';
import '../../widgets/pesquisar/pesquisar_widget.dart';
import '../item_lista/item_listagem_principal.dart';

class PesquisarTitulo extends Pesquisar {
  final String rota;
  final ListagemPrincipal controller = Modular.get<ListagemPrincipal>();

  PesquisarTitulo({
    @required this.rota,
  });

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        controller.listar();
        close(context, '');
      },
    );
  }

  Widget listTitulos() {
    List<TituloModel> titulos = controller.pesquisar(query);
    return ListView.separated(
      itemCount: titulos.length,
      itemBuilder: (_, index) {
        return ItemListagemPrincipal(
          titulo: titulos[index],
          onPressed: controller.addFavorito,
          rota: '/mangas/manga',
        );
      },
      separatorBuilder: (_, index) => Divider(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return listTitulos();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return super.buildSuggestions(context);
    }
    return listTitulos();
  }
}
