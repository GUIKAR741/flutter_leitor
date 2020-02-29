import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/mangas/mangas_controller.dart';
import '../../modules/mangas/mangas_page.dart';
import '../../modules/mangas/pages/ler/ler_controller.dart';
import '../../modules/mangas/pages/manga/manga_controller.dart';
import '../../modules/mangas/pages/manga/manga_page.dart';
import '../../modules/mangas/repositories/manga_repository.dart';
import '../../modules/mangas/repositories/mangas_repository.dart';
import '../../shared/controllers/ler.dart';
import '../../shared/controllers/listagem_principal.dart';
import '../../shared/interfaces/repository_principal.dart';
import '../../shared/interfaces/repository_unique.dart';
import '../../shared/pages/ler/ler_page.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ListagemPrincipal>((i) => MangasController()),
        Bind((i) => MangaController()),
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
