import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/models/titulo_model.dart';
import '../../shared/widgets/drawer/drawer_custom.dart';
import '../../shared/widgets/pesquisar/pesquisar_titulo_widget.dart';
import 'animes_controller.dart';

class AnimesPage extends StatelessWidget {
  final String title;
  final AnimesController controller = Modular.get<AnimesController>();

  AnimesPage({Key key, this.title = "Animes"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: PesquisarTitulo(
                      path: '/animes/anime', controller: controller));
            },
            tooltip: "Pesquisar",
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.titulos.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<TituloModel> titulos = controller.titulos.value;
          return RefreshIndicator(
            onRefresh: () async {
              controller.listar(refresh: true);
            },
            child: titulos.length > 0
                ? Scrollbar(
                    controller: controller.scroll,
                    child: ListView.separated(
                      controller: controller.scroll,
                      itemCount: titulos.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          leading: ExtendedImage.network(titulos[index].imagem,
                              width: 50,
                              cache: true,
                              enableMemoryCache: true,
                              fit: BoxFit.fill),
                          title: Text(titulos[index].nome),
                          onTap: () {
                            Modular.to.pushNamed('/animes/anime',
                                arguments: titulos[index]);
                          },
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                    ),
                  )
                : Center(
                    child: RaisedButton(
                      child: Text("Recarregar Titulos"),
                      onPressed: () => controller.listar(refresh: true),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
