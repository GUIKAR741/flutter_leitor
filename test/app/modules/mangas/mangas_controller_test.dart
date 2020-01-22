import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/mangas/mangas_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';

void main() {
  initModules([AppModule(), MangasModule()]);
  MangasController mangas;

  setUp(() {
    mangas = MangasModule.to.get<MangasController>();
  });

  group('MangasController Test', () {
    test("First Test", () {
      expect(mangas, isInstanceOf<MangasController>());
    });
  });
}
