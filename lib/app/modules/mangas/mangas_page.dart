import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/mangas/mangas_controller.dart';
import '../../shared/models/titulo_model.dart';
import '../../shared/widgets/drawer/drawer_custom.dart';
import '../../shared/widgets/pesquisar/pesquisar_titulo_widget.dart';

class MangasPage extends StatelessWidget {
  final String title;
  final MangasController controller = Modular.get<MangasController>();

  MangasPage({Key key, this.title = "Mangas"}) : super(key: key);

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
                  path: '/mangas/manga',
                  controller: controller,
                ),
              );
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
                          leading: Container(
                            height: 100,
                            width: 50,
                            child: ExtendedImage.network(titulos[index].imagem,
                                cache: true, fit: BoxFit.fill),
                          ),
                          title: Text(titulos[index].nome),
                          onTap: () {
                            Modular.to.pushNamed('/mangas/manga',
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
