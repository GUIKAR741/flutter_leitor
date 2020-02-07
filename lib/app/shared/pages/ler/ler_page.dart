import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leitor/app/shared/controllers/ler.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/ler_controle/ler_controle.dart';
import 'package:flutter_leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class LerPage extends StatefulWidget {
  final CapituloModel capitulo;

  LerPage({
    Key key,
    @required this.capitulo,
  }) : super(key: key);

  @override
  _LerPageState createState() => _LerPageState();
}

class _LerPageState extends ModularState<LerPage, Ler> {
  @override
  void initState() {
    super.initState();
    controller.capitulo = widget.capitulo;
    controller.listarImagens();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  Widget mostrarPaginas() {
    return Observer(
      builder: (_) {
        return controller.pagina.isNotEmpty
            ? FlatButton(
                child: DefaultTextStyle(
                  child: Text(
                    controller.pagina,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: Theme.of(context).primaryTextTheme.title,
                ),
                onPressed: controller.lerController.esconderControle ||
                        controller.imagens.value.length <= 1
                    ? null
                    : () {
                        Get.dialog(
                          MudarPaginaWidget(
                            paginas: controller.imagens.value.length,
                            onPressed: controller.irPara,
                          ),
                        );
                      },
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Observer(
          builder: (_) {
            return Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: controller.lerController.mudar,
                  child: controller.imagens?.value != null
                      ? PreloadPageView(
                          controller: controller.pageController,
                          onPageChanged:
                              controller.paginacao ? controller.mudar : null,
                          children: controller.imagens.value,
                          preloadPagesCount: 5,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                LerControle(
                  controller: controller.lerController,
                  title: Observer(
                    builder: (_) {
                      return DefaultTextStyle(
                        style: Theme.of(context).primaryTextTheme.title,
                        child: Text(
                          controller.capitulo != null
                              ? controller.capitulo.titulo
                              : '',
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    mostrarPaginas(),
                    IconButton(
                      icon: Icon(Icons.screen_rotation),
                      onPressed: controller.lerController.esconderControle
                          ? null
                          : controller.virar,
                      tooltip: 'Virar Tela',
                    ),
                    Observer(
                      builder: (_) => IconButton(
                        icon: Icon(
                          controller.icone,
                        ),
                        onPressed: controller.lerController.esconderControle
                            ? null
                            : controller.pausar,
                        tooltip: "Play/Pause",
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
