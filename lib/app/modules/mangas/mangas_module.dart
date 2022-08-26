import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/modules/hqs/pages/ler/ler_store.dart';
import 'package:leitor/app/modules/mangas/pages/manga/manga_page.dart';
import 'package:leitor/app/modules/mangas/pages/manga/manga_store.dart';
import 'package:leitor/app/modules/mangas/pages/mangas/mangas_page.dart';
import 'package:leitor/app/modules/mangas/pages/mangas/mangas_store.dart';
import 'package:leitor/app/shared/pages/ler/ler_page.dart';
import 'package:leitor/app/shared/repositories/mangas/manga_repository.dart';
import 'package:leitor/app/shared/repositories/mangas/mangas_repository.dart';

class MangasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MangasStore()),
    Bind.lazySingleton((i) => MangaStore()),
    Bind.factory((i) => LerStore(
          i.args.data['controller'],
          i.args.data['capEp'],
        )),
    Bind.lazySingleton((i) => MangasRepository()),
    Bind.lazySingleton((i) => MangaRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MangasPage()),
    ChildRoute('/manga', child: (_, args) => const MangaPage()),
    ChildRoute('/ler_manga', child: (_, args) => const LerPage()),
  ];
}
