import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hqs_repository.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_controller.dart';
import 'package:flutter_leitor/app/shared/dio/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_page.dart';

import 'pages/hq/hq_page.dart';
import 'pages/ler/ler_page.dart';

class HqsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LerController(i.get<HqRepository>()), singleton: false),
        Bind((i) => HqController(i.get<HqRepository>())),
        Bind((i) => HqsRepository(Modular.get<DioService>())),
        Bind((i) => HqRepository(Modular.get<DioService>())),
        Bind((i) => HqsController(i.get<HqsRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HqsPage()),
        Router('/hq', child: (_, args) => HqPage(hq: args.data)),
        Router('/ler_hq', child: (_, args) => LerPage(capitulo: args.data)),
      ];

  static Inject get to => Inject<HqsModule>.of();
}
