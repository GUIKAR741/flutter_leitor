import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/controllers/ler.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:preload_page_view/preload_page_view.dart';

class LerPage extends StatefulWidget {
  final CapituloModel capitulo;
  final Ler controller;

  LerPage({
    Key key,
    @required this.capitulo,
    @required this.controller,
  }) : super(key: key);

  @override
  _LerPageState createState() => _LerPageState();
}

class _LerPageState extends State<LerPage> {
  Ler get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    controller.capitulo = widget.capitulo;
    controller.listarImagens();
    controller.pageController.addListener(
      () => controller.listenerPage(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    controller.pageController.removeListener(
      () => controller.listenerPage(context),
    );
  }

  Widget mostrarPaginas() {
    return Observer(
      builder: (_) {
        return controller.pagina.isNotEmpty
            ? MudarPaginaWidget(
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
                ativarBotao: controller.paginacao,
                paginas: controller.imagens.value.length,
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
          // IconButton(
          //   icon: Icon(Icons.screen_rotation),
          //   onPressed: (){
          //     if(mudar){
          //       SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
          //     }else{
          //       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
          //     }
          //     mudar = !mudar;
          //   },
          // ),
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
          return controller.imagens?.value != null
              ? PreloadPageView(
                  controller: controller.pageController,
                  onPageChanged: controller.paginacao ? controller.mudar : null,
                  children: controller.imagens.value,
                  preloadPagesCount: 5,
                )
              : CircularProgressIndicator();
        }),
      ),
    );
  }
}
