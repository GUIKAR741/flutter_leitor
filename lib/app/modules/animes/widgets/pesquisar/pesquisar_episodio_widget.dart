import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_controller.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pesquisar/pesquisar_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PesquisarEpisodio extends Pesquisar {
  AnimeController controller = Modular.get<AnimeController>();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          controller.listarTitulo();
          close(context, '');
        });
  }

  Widget listEpisodios() {
    List<CapEpModel> episodios = controller.pesquisar(query);
    return ListView.separated(
      itemCount: episodios.length,
      itemBuilder: (_, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          leading: Container(
            height: 100,
            width: 50,
            child: ExtendedImage.network(episodios[index].imagem,
                cache: true, fit: BoxFit.fill),
          ),
          title: Text(episodios[index].titulo),
          onTap: () {
            // print(episodios[index]);
            Modular.to.pushNamed('/animes/anime', arguments: episodios[index]);
          },
        );
      },
      separatorBuilder: (_, index) => Divider(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return listEpisodios();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.buildSuggestions(context);
    return listEpisodios();
  }
}
