import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';

void main() {
  initModules([AppModule(), MangasModule()]);
  LerController ler;

  setUp(() {
    ler = MangasModule.to.get<LerController>();
  });

  group('LerController Test', () {
    test("First Test", () {
      expect(ler, isInstanceOf<LerController>());
    });
  });
}
