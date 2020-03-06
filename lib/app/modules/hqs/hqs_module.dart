import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/controllers/ler.dart';
import '../../shared/controllers/listagem_principal.dart';
import '../../shared/interfaces/repository_principal.dart';
import '../../shared/interfaces/repository_unique.dart';
import '../../shared/pages/ler/ler_page.dart';
import 'hqs_controller.dart';
import 'hqs_page.dart';
import 'pages/hq/hq_controller.dart';
import 'pages/hq/hq_page.dart';
import 'pages/ler/ler_controller.dart';
import 'repositories/hq_repository.dart';
import 'repositories/hqs_repository.dart';

class HqsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ListagemPrincipal>((i) => HqsController()),
        Bind<ListagemTitulo>((i) => HqController()),
        Bind<Ler>((i) => LerController(i.get<HqController>())),
        Bind<IRepositoryPrincipal>((i) => HqsRepository()),
        Bind<IRepositoryUnique>((i) => HqRepository()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HqsPage()),
        Router('/hq', child: (_, args) => HqPage()),
        Router('/ler_hq', child: (_, args) => LerPage()),
      ];

  static Inject get to => Inject<HqsModule>.of();
}
