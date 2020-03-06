import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/controllers/listagem_principal.dart';
import '../../shared/controllers/listagem_titulo.dart';
import '../../shared/interfaces/repository_principal.dart';
import '../../shared/interfaces/repository_unique.dart';
import 'animes_controller.dart';
import 'animes_page.dart';
import 'pages/anime/anime_controller.dart';
import 'pages/anime/anime_page.dart';
import 'repositories/anime_repository.dart';
import 'repositories/animes_repository.dart';

class AnimesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ListagemPrincipal>((i) => AnimesController()),
        Bind<ListagemTitulo>((i) => AnimeController()),
        Bind<IRepositoryPrincipal>((i) => AnimesRepository()),
        Bind<IRepositoryUnique>((i) => AnimeRepository()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => AnimesPage()),
        Router('/anime', child: (_, args) => AnimePage()),
      ];

  static Inject get to => Inject<AnimesModule>.of();
}
