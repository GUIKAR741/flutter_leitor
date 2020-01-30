import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_controller.dart';
// import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_page.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_page.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_controller.dart';
import 'package:flutter_leitor/app/shared/dio/dio_service.dart';
import 'package:flutter_leitor/app/shared/pages/ler/ler_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LerController(i.get<MangaRepository>()), singleton: false),
        Bind((i) => MangaController(i.get<MangaRepository>())),
        Bind((i) => MangasRepository(Modular.get<DioService>())),
        Bind((i) => MangaRepository(Modular.get<DioService>())),
        Bind((i) => MangasController(i.get<MangasRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => MangasPage()),
        Router('/manga', child: (_, args) => MangaPage(manga: args.data)),
        Router('/ler_manga',
            child: (_, args) => LerPage(
                  capitulo: args.data,
                  controller: Modular.get<LerController>(),
                )),
      ];

  static Inject get to => Inject<MangasModule>.of();
}
