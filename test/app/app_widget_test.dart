import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() async {
  Hive.init(Directory.current.path + "/hive");
  Modular.debugMode = false;
  ModularApp modularApp = ModularApp(
    module: AppModule(),
  );

  group('AppWidget Test', () {
    testWidgets('App possui um material app', (WidgetTester tester) async {
      await tester.pumpWidget(
        modularApp,
      );
      final materialApp = find.byWidgetPredicate(
        (Widget e) => e is MaterialApp,
      );
      expect(materialApp, findsOneWidget);
    });
  });
}
