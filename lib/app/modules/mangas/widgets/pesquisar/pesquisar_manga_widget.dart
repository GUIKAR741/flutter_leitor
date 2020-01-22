import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_controller.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pesquisar/pesquisar_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PesquisarManga extends Pesquisar {
  MangasController controller = Modular.get<MangasController>();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          controller.listar();
          close(context, '');
        });
  }

  Widget listTitulos() {
    List<TituloModel> titulos = controller.pesquisar(query);
    return ListView.separated(
      itemCount: titulos.length,
      itemBuilder: (_, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          leading: Container(
            height: 100,
            width: 50,
            child: ExtendedImage.network(titulos[index].imagem,
                cache: true, fit: BoxFit.fill),
          ),
          title: Text(titulos[index].nome),
          onTap: () {
            Modular.to.pushNamed('/mangas/manga', arguments: titulos[index]);
          },
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
