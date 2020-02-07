import 'package:flutter_leitor/app/modules/mangas/mangas_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_page.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/ler.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/pages/ler/ler_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        Router('/manga', child: (_, args) => MangaPage(manga: args.data)),
        Router('/ler_manga', child: (_, args) => LerPage(capitulo: args.data)),
      ];

  static Inject get to => Inject<MangasModule>.of();
}
