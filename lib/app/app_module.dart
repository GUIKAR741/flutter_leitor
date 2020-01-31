import 'package:dio/dio.dart';
import 'package:flutter_leitor/app/shared/dio/dio_service.dart';
import 'package:flutter_leitor/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_widget.dart';
import 'package:flutter_leitor/app/modules/home/home_module.dart';

import 'modules/animes/animes_module.dart';
import 'modules/assistir/assistir_module.dart';
import 'modules/hqs/hqs_module.dart';
import 'modules/mangas/mangas_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => DioService(i.get<Dio>())),
        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router(
          Modular.initialRoute,
          module: HomeModule(),
        ),
        Router(
          '/mangas',
          module: MangasModule(),
        ),
        Router(
          '/animes',
          module: AnimesModule(),
        ),
        Router(
          '/assistir',
          module: AssistirModule(),
        ),
        Router(
          '/hqs',
          module: HqsModule(),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
