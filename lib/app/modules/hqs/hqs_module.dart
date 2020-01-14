import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_page.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_bloc.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_page.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hqs_repository.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_bloc.dart';
import 'package:flutter_leitor/app/shared/dio/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_page.dart';

import '../../app_module.dart';

class HqsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LerBloc(i.get<HqRepository>())),
        Bind((i) => HqRepository(AppModule.to.get<CustomDio>())),
        Bind((i) => HqBloc(i.get<HqRepository>())),
        Bind((i) => HqsRepository(AppModule.to.get<CustomDio>())),
        Bind((i) => HqsBloc(i.get<HqsRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HqsPage()),
        Router('/hq', child: (_, args) => HqPage(hq: args.data)),
        Router('/ler_hq', child: (_, args) => LerPage(capitulo: args.data)),
      ];

  static Inject get to => Inject<HqsModule>.of();
}
