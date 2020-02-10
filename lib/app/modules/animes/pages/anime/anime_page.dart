import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/widgets/pesquisar/pesquisar_episodio_widget.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/widgets/card/card_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'anime_controller.dart';

class AnimePage extends StatelessWidget {
  final AnimeController controller = Modular.get<AnimeController>();
  AnimePage({Key key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.listarTitulo();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.titulo.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(context: context, delegate: PesquisarEpisodio());
            },
            tooltip: "Pesquisar",
          ),
          IconButton(
            onPressed: controller.reversed,
            icon: Icon(Icons.swap_vert),
            tooltip: 'Inverter',
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.lista.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<EpisodioModel> episodios = controller.listagem;
          return Column(
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => controller.listarTitulo(),
                  child: episodios.length > 0
                      ? DraggableScrollbar.semicircle(
                          controller: controller.scroll,
                          child: ListView.separated(
                            controller: controller.scroll,
                            itemCount: episodios.length,
                            itemBuilder: (_, index) {
                              return index == 0
                                  ? Column(
                                      children: <Widget>[
                                        CardWidget(
                                          titulo: controller.titulo,
                                        ),
                                        listTile(episodios[index])
                                      ],
                                    )
                                  : listTile(episodios[index]);
                            },
                            separatorBuilder: (_, index) => Divider(),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            CardWidget(
                              titulo: controller.titulo,
                            ),
                            Center(
                              child: RaisedButton(
                                child: Text("Recarregar"),
                                onPressed: controller.listarTitulo,
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

  Widget listTile(EpisodioModel episodio) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        height: 100,
        width: 70,
        child: ExtendedImage.network(
          episodio.imagem,
          cache: true,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(episodio.titulo),
      subtitle: Text(episodio.info),
      trailing: Observer(
        builder: (_) {
          return IconButton(
            icon: Icon(
              episodio.status ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            tooltip: episodio.status ? "Lido" : "Não Lido",
            onPressed: () => controller.addLista(episodio.titulo, episodio),
          );
        },
      ),
      onTap: () {
        controller.addLista(episodio.titulo, episodio, add: true);
        Modular.to.pushNamed('/assistir', arguments: episodio);
      },
    );
  }
}
