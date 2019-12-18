import 'package:flutter_leitor/app/modules/animes/animes_page.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class AnimesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AnimesRepository(i.get<Dio>())),
        Bind((i) => AnimesBloc()),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => AnimesPage()),
  ];

  static Inject get to => Inject<AnimesModule>.of();
}
