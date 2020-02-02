import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/widgets/ler_controle/ler_controle_controller.dart';

void main() {
  LerControleController lercontrole;

  setUp(() {
    lercontrole = LerControleController();
  });

  group('LerControleController Test', () {
    test("First Test", () {
      expect(lercontrole, isInstanceOf<LerControleController>());
    });
  });
}
