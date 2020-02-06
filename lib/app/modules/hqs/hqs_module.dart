import 'package:flutter_leitor/app/modules/hqs/hqs_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_page.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hqs_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/ler.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_principal.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/pages/ler/ler_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/hq/hq_page.dart';

class HqsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ListagemPrincipal>((i) => HqsController()),
        Bind<ListagemTitulo>((i) => HqController()),
        Bind<Ler>((i) => LerController()),
        Bind<IRepositoryPrincipal>((i) => HqsRepository()),
        Bind<IRepositoryUnique>((i) => HqRepository()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HqsPage()),
        Router('/hq', child: (_, args) => HqPage(hq: args.data)),
        Router('/ler_hq', child: (_, args) => LerPage(capitulo: args.data)),
      ];

  static Inject get to => Inject<HqsModule>.of();
}
