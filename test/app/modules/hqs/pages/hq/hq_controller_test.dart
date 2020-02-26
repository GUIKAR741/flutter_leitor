import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_controller.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Hive.init(Directory.current.path + "/hive");
  initModules([AppModule(), HqsModule()]);
  HqController hq;

  setUp(() {
    hq = HqsModule.to.get<HqController>();
  });

  group('HqController Test', () {
    test("First Test", () {
      expect(hq, isInstanceOf<HqController>());
    });
  });
}
