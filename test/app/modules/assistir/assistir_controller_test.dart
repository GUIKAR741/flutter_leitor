import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/assistir/assistir_controller.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';

void main() {
  initModules([AppModule(), AssistirModule()]);
  AssistirController assistir;

  setUp(() {
    assistir = AssistirModule.to.get<AssistirController>();
  });

  group('AssistirController Test', () {
    test("First Test", () {
      expect(assistir, isInstanceOf<AssistirController>());
    });
  });
}
