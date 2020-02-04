import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_controller.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/modules/animes/animes_controller.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/animes/animes_page.dart';

import 'pages/anime/anime_page.dart';

class AnimesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AnimeController(i.get<AnimeRepository>())),
        Bind((i) => AnimesRepository(Modular.get<DioService>())),
        Bind((i) => AnimeRepository(Modular.get<DioService>())),
        Bind((i) => AnimesController(i.get<AnimesRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => AnimesPage()),
        Router('/anime', child: (_, args) => AnimePage(anime: args.data)),
      ];

  static Inject get to => Inject<AnimesModule>.of();
}
