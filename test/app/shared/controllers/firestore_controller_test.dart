import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/shared/controllers/firestore_controller.dart';
import 'package:flutter_leitor/app/app_module.dart';

void main() {
  initModule(AppModule());
  FirestoreController firestore;

  setUp(() {
    firestore = AppModule.to.get<FirestoreController>();
  });

  group('FirestoreController Test', () {
    test("First Test", () {
      expect(firestore, isInstanceOf<FirestoreController>());
    });
  });
}
