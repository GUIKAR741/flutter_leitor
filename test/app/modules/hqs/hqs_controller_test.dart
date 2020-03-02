import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/hqs/hqs_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:hive/hive.dart';

void main() {
  Hive.init(Directory.current.path + "/hive");
  initModules([AppModule(), HqsModule()]);
  HqsController hqs;

  setUp(() {
    hqs = HqsModule.to.get<HqsController>();
  });

  group('HqsController Test', () {
    test("First Test", () {
      expect(hqs, isInstanceOf<HqsController>());
    });
  });
}
