import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/controllers/ler.dart';
import '../../shared/controllers/listagem_principal.dart';
import '../../shared/interfaces/repository_principal.dart';
import '../../shared/interfaces/repository_unique.dart';
import '../../shared/pages/ler/ler_page.dart';
import 'mangas_controller.dart';
import 'mangas_page.dart';
import 'pages/ler/ler_controller.dart';
import 'pages/manga/manga_controller.dart';
import 'pages/manga/manga_page.dart';
import 'repositories/manga_repository.dart';
import 'repositories/mangas_repository.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ListagemPrincipal>((i) => MangasController()),
        Bind<ListagemTitulo>((i) => MangaController()),
        Bind<Ler>((i) => LerController(i.get<MangaController>())),
        Bind<IRepositoryPrincipal>((i) => MangasRepository()),
        Bind<IRepositoryUnique>((i) => MangaRepository()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => MangasPage()),
        Router('/manga', child: (_, args) => MangaPage()),
        Router('/ler_manga', child: (_, args) => LerPage()),
      ];

  static Inject get to => Inject<MangasModule>.of();
}
