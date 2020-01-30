import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_leitor/app/app_controller.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobx/mobx.dart';

class Shared extends Mock implements SharedPreferences{
  Map<String, dynamic> data = {};

  void iniciaData(){
    data['dark'] = false;
  }

  void limpaData(){
    data.clear();
  }

  @override
  Future<bool> setBool(String key, bool value) {
    data[key] = value;
    return Future.value(value);
  }

  @override
  bool getBool(String key) {
    return data[key];
  }
}

void main() {
  initModule(AppModule());
  AppController app;
  Shared shared;

  setUp(() {
    app = Modular.get<AppController>();
    shared = Shared();
    app.prefsTest = Future.value(shared).asObservable();
  });

  group('AppController Test', () {
    test("First Test", () {
      expect(app, isInstanceOf<AppController>());
    });

    test('Tema muda para false', (){
      app.mudarTema();
      expect(app.tema, false);
    });

    test('Tema muda para true', (){
      shared.iniciaData();
      app.mudarTema();
      expect(app.tema, true);
    });
  });
}
