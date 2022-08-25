import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/listagem_principal.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:leitor/app/shared/widgets/item_lista/item_listagem_principal.dart';
import 'package:leitor/app/shared/widgets/pesquisar/pesquisar_widget.dart';

class PesquisarTitulo extends Pesquisar {
  final String rota;
  final ListagemPrincipal controller = Modular.get();

  PesquisarTitulo({
    required this.rota,
  });

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        controller.listar();
        close(context, '');
      },
    );
  }

  Widget listTitulos() {
    List<TituloModel> titulos = controller.pesquisar(query)!;
    return ListView.separated(
      itemCount: titulos.length,
      itemBuilder: (_, index) {
        return ItemListagemPrincipal(
          titulo: titulos[index],
          onPressed: controller.addFavorito,
          rota: rota,
        );
      },
      separatorBuilder: (_, index) => const Divider(),
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
