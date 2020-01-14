import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_page.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_page.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LerBloc(i.get<MangaRepository>())),
        Bind((i) => MangaRepository(AppModule.to.get<CustomDio>())),
        Bind((i) => MangasBloc(i.get<MangasRepository>())),
        Bind((i) => MangasRepository(AppModule.to.get<CustomDio>())),
        Bind((i) => MangaBloc(i.get<MangaRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => MangasPage()),
        Router('/manga', child: (_, args) => MangaPage(manga: args.data)),
        Router('/ler_manga', child: (_, args) => LerPage(capitulo: args.data)),
      ];

  static Inject get to => Inject<MangasModule>.of();
}
