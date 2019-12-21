import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_page.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LerBloc()),
        Bind((i) => MangaRepository(i.get<Dio>())),
        Bind((i) => MangasBloc(i.get<MangasRepository>())),
        Bind((i) => MangasRepository(i.get<Dio>())),
        Bind((i) => MangaBloc(i.get<MangaRepository>())),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => MangasPage()),
        Router('/manga', child: (_, args) => MangaPage(manga: args.data)),
      ];

  static Inject get to => Inject<MangasModule>.of();
}
