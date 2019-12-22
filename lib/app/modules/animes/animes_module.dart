import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/animes_page.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_page.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

import '../../app_module.dart';

class AnimesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AnimeRepository(AppModule.to.get<CustomDio>())),
        Bind((i) => AnimeBloc(i.get<AnimeRepository>())),
        Bind((i) => AnimesRepository(AppModule.to.get<CustomDio>())),
        Bind((i) => AnimesBloc(i.get<AnimesRepository>())),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => AnimesPage()),
        Router('/anime', child: (_, args) => AnimePage(anime: args.data)),
      ];

  static Inject get to => Inject<AnimesModule>.of();
}
