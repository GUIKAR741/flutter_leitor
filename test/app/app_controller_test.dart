import 'dart:io';

import 'package:flutter_leitor/app/app_controller.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() async {
  Hive.init(Directory.current.path + "/hive");
  initModule(AppModule());
  AppController app;

  setUp(() async {
    app = Modular.get<AppController>();
  });

  group('AppController Test', () {
    test("app é instancia de AppController", () {
      expect(app, isInstanceOf<AppController>());
    });

    test('Tema muda para false', () async {
      await app.mudarTema();
      expect(app.tema, false);
    });

    test('Tema muda para true', () async {
      await app.mudarTema();
      expect(app.tema, true);
    });

    test("AppModule inject retorna AppController", () {
      expect(
        AppModule.to.get<AppController>(),
        isInstanceOf<AppController>(),
      );
    });

    test("Dispose close the box", () async {
      await app.box;
      expect(Hive.isBoxOpen('theme'), true);
      await app.dispose();
      expect(Hive.isBoxOpen('theme'), false);
    });
  });
}
