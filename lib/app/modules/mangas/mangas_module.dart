import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class MangasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MangasRepository(i.get<Dio>())),
        Bind((i) => MangasBloc()),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => MangasPage()),
  ];

  static Inject get to => Inject<MangasModule>.of();
}
