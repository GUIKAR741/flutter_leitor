import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/shared/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_widget.dart';
import 'package:flutter_leitor/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AnimesRepository()),
        Bind((i) => MangasRepository()),
        Bind((i) => AppBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
        Router('/mangas', module: MangasModule()),
        Router('/animes', module: AnimesModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
