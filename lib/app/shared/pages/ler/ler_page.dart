import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/ler.dart';
import 'package:leitor/app/shared/widgets/ler_controle/ler_controle.dart';
import 'package:leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:preload_page_view/preload_page_view.dart';

class LerPage extends StatefulWidget {
  const LerPage({Key? key}) : super(key: key);

  @override
  State<LerPage> createState() => _LerPageState();
}

class _LerPageState extends State<LerPage> {
  final Ler controller = Modular.get();

  @override
  void initState() {
    super.initState();
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Widget mostrarPaginas() {
    return Observer(
      builder: (_) {
        return controller.pagina!.isNotEmpty
            ? TextButton(
                onPressed: controller.lerController.esconderControle ||
                        controller.imagens!.value!.length <= 1
                    ? null
                    : () {
                        asuka.showDialog(
                          builder: (context) => MudarPaginaWidget(
                            paginas: controller.imagens!.value!.length,
                            onPressed: (String pagina) =>
                                controller.irPara(context, pagina),
                          ),
                        );
                      },
                child: DefaultTextStyle(
                  style: Theme.of(context).primaryTextTheme.headline6!,
                  child: Text(
                    controller.pagina!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
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
                        preloadPagesCount: 5,
                        children: controller.imagens!.value!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              LerControle(
                controller: controller.lerController,
                title: Observer(
                  builder: (_) {
                    return DefaultTextStyle(
                      style: Theme.of(context).primaryTextTheme.headline6!,
                      child: Text(
                        controller.capitulo != null
                            ? controller.capitulo!.titulo!
                            : '',
                      ),
                    );
                  },
                ),
                actions: <Widget>[
                  mostrarPaginas(),
                  IconButton(
                    icon: const Icon(Icons.screen_rotation),
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
    );
  }
}
