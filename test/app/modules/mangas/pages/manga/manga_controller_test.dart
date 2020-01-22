import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';

void main() {
  initModules([AppModule(), MangasModule()]);
  MangaController manga;

  setUp(() {
    manga = MangasModule.to.get<MangaController>();
  });

  group('MangaController Test', () {
    test("First Test", () {
      expect(manga, isInstanceOf<MangaController>());
    });
  });
}
