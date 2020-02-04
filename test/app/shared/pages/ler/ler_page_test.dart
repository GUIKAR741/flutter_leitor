// import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/pages/ler/ler_page.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('HQs', () {
    setUpAll(() {
      initModules([AppModule(), HqsModule()]);
    });
    testWidgets('LerPage has title', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(LerPage(
        capitulo: CapituloModel(titulo: 'Capitulo HQ'),
      )));
      await tester.pump(Duration(minutes: 1));
      final titleFinder = find.text('Capitulo HQ');
      expect(titleFinder, findsOneWidget);
    });
  });
  group('Mangas', () {
    setUpAll(() {
      initModules([AppModule(), MangasModule()]);
    });
    testWidgets('LerPage has title', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(LerPage(
        capitulo: CapituloModel(titulo: 'Capitulo Manga'),
      )));
      await tester.pump(Duration(minutes: 1));
      final titleFinder = find.text('Capitulo Manga');
      expect(titleFinder, findsOneWidget);
    });
  });
}
