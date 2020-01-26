import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_controller.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preload_page_view/preload_page_view.dart';

class LerPage extends StatefulWidget {
  final CapituloModel capitulo;

  LerPage({Key key, this.capitulo}) : super(key: key);

  @override
  _LerPageState createState() => _LerPageState();
}

class _LerPageState extends State<LerPage> {
  final LerController controller = Modular.get<LerController>();

  @override
  void initState() {
    super.initState();
    controller.capitulo = widget.capitulo;
    controller.listarImagens();
    controller.pageController.addListener(
      () => controller.listenerPage(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.pageController.removeListener(
      () => controller.listenerPage(context),
    );
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
                paginas: controller.imagens.length,
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
        title: Observer(
          builder: (_) {
            return Text(
              controller.capitulo != null ? controller.capitulo.titulo : '',
            );
          },
        ),
        actions: <Widget>[
          Center(
            child: mostrarPaginas(),
          ),
          Observer(builder: (_) {
            return IconButton(
              icon: Icon(
                controller.icone,
              ),
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
