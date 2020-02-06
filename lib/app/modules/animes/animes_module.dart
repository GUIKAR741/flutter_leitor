import 'package:flutter_leitor/app/modules/animes/animes_controller.dart';
import 'package:flutter_leitor/app/modules/animes/animes_page.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_controller.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/anime/anime_page.dart';

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
        Router('/anime', child: (_, args) => AnimePage(anime: args.data)),
      ];

  static Inject get to => Inject<AnimesModule>.of();
}
