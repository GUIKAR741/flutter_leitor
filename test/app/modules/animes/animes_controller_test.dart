import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/animes/animes_controller.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';

void main() {
  initModules([AppModule(), AnimesModule()]);
  AnimesController animes;

  setUp(() {
    animes = AnimesModule.to.get<AnimesController>();
  });

  group('AnimesController Test', () {
    test("First Test", () {
      expect(animes, isInstanceOf<AnimesController>());
    });
  });
}
