import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_controller.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pesquisar/pesquisar_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PesquisarCapitulo extends Pesquisar {
  MangaController controller = Modular.get<MangaController>();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          controller.listarTitulo();
          close(context, '');
        });
  }

  Widget listCapitulos() {
    List<CapituloModel> capitulos = controller.pesquisar(query);
    return ListView.separated(
      itemCount: capitulos.length,
      itemBuilder: (_, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          title: Text(capitulos[index].titulo),
          subtitle: Text(capitulos[index].info),
          onTap: () {
            Modular.to
                .pushNamed('/mangas/ler_manga', arguments: capitulos[index]);
          },
        );
      },
      separatorBuilder: (_, index) => Divider(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return listCapitulos();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return super.buildSuggestions(context);
    }
    return listCapitulos();
  }
}
