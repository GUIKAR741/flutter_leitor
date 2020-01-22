import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_controller.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preload_page_view/preload_page_view.dart';

class LerPage extends StatelessWidget {
  final CapituloModel capitulo;
  final LerController controller = Modular.get<LerController>();

  LerPage({Key key, this.capitulo}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.capitulo = capitulo;
    controller.listarImagens();
    return super.createElement();
  }

  Widget mostrarPaginas() {
    return Observer(
      builder: (_) {
        return controller.pagina.isNotEmpty
            ? MudarPaginaWidget(
                child: Text(
                  controller.pagina,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: controller.escrever,
                onPressed: controller.irPara,
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitulo.titulo),
        actions: <Widget>[
          Center(
            child: mostrarPaginas(),
          ),
          Observer(builder: (_) {
            return IconButton(
              icon: Icon(controller.icone),
              onPressed: controller.pausar,
              tooltip: "Play/Pause",
            );
          }),
        ],
      ),
      body: Center(
        child: Observer(builder: (_) {
          return controller.imagens != null
              ? PreloadPageView(
                  controller: controller.pageController,
                  onPageChanged: controller.paginacao ? controller.mudar : null,
                  children: controller.imagens,
                  preloadPagesCount: 5,
                )
              : CircularProgressIndicator();
        }),
      ),
    );
  }
}
