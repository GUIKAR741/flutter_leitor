import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/modules/hqs/pages/hq/hq_page.dart';
import 'package:leitor/app/modules/hqs/pages/hq/hq_store.dart';
import 'package:leitor/app/modules/hqs/pages/hqs/hqs_store.dart';
import 'package:leitor/app/modules/hqs/pages/ler/ler_store.dart';
import 'package:leitor/app/shared/pages/ler/ler_page.dart';
import 'package:leitor/app/shared/repositories/hqs/hq_repository.dart';
import 'package:leitor/app/shared/repositories/hqs/hqs_repository.dart';

import 'pages/hqs/hqs_page.dart';

class HqsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HqsStore()),
    Bind.lazySingleton((i) => HqStore()),
    Bind.factory((i) => LerStore(
          i.args.data['controller'],
          i.args.data['capEp'],
        )),
    Bind.lazySingleton((i) => HqsRepository()),
    Bind.lazySingleton((i) => HqRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HqsPage()),
    ChildRoute('/hq', child: (_, args) => const HqPage()),
    ChildRoute('/ler_hq', child: (_, args) => const LerPage()),
  ];
}
