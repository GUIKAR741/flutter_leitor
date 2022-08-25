import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/theme_store.dart';
import 'package:leitor/app/shared/services/dio_service.dart';
import 'package:leitor/app/shared/widgets/drawer/drawer_custom.dart';

class HomePage extends StatelessWidget {
  final ThemeStore controller = Modular.get();
  final String title = "Leitor";

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: "Limpar Imagens",
            onPressed: () {
              DioService dio = Modular.get();
              dio.optionsCache?.store?.clean();
              if (!kIsWeb) {
                clearDiskCachedImages();
                clearMemoryImageCache();
              }
            },
          ),
          Observer(
            builder: (_) {
              if (controller.temaBox == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              IconData icone = (controller.temaValue
                  ? Icons.brightness_7
                  : Icons.brightness_3);
              return IconButton(
                tooltip: "Mudar Tema",
                icon: Icon(icone),
                onPressed: controller.mudarTema,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed('/hqs/'),
              child: const Text("Ler HQs"),
            ),
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed('/mangas/'),
              child: const Text("Ler Mangás"),
            ),
            // ElevatedButton(
            //   onPressed: () => Modular.to.pushNamed('/animes'),
            //   child: const Text("Assistir Animes"),
            // ),
          ],
        ),
      ),
    );
  }
}
