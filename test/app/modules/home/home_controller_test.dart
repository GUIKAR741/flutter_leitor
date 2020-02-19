import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_leitor/app/modules/home/home_controller.dart';
import 'package:flutter_leitor/app/modules/home/home_module.dart';

void main() {
  initModule(HomeModule());
  HomeController home;

  setUp(() {
    home = Modular.get<HomeController>();
  });

  group('HomeController Test', () {
    test("Home é instancia de HomeController", () {
      expect(home, isInstanceOf<HomeController>());
    });
    test("Home é instancia de HomeController no HomeModule", () {
      expect(
          HomeModule.to.get<HomeController>(), isInstanceOf<HomeController>());
    });
    test(
        "HomeController do Modular.get é igual ao HomeController no HomeModule",
        () {
      expect(home, HomeModule.to.get<HomeController>());
    });
  });
}
