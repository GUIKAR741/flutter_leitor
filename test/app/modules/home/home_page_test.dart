import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/home/home_module.dart';
import 'package:flutter_leitor/app/modules/home/home_page.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  HomeModule homeModule = HomeModule();
  initModule(AppModule(), initialModule: true);
  initModules([homeModule, HqsModule(), MangasModule(), AnimesModule()]);
  HomePage home = HomePage(title: 'Home');
  group('HomePage Tests', () {
    testWidgets('HomePage has title', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(home));
      final titleFinder = find.text('Home');
      expect(titleFinder, findsOneWidget);
    });
    testWidgets('Clicar botão de limpar o cache', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(home),
      );
      final clear = find.byIcon(Icons.clear);
      await tester.tap(clear);
      expect(clear, findsOneWidget);
    });
    testWidgets('Ir para pagina hqs', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(home));
      final hqs = find.byWidgetPredicate(
        (Widget widget) =>
            widget is RaisedButton &&
            widget.child is Text &&
            (widget.child as Text).data == 'Ler HQs',
      );
      await (await tester.press(hqs)).up();
      expect('/hqs', Modular.actualRoute);
    });
    testWidgets('Ir para pagina mangas', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(home));
      final mangas = find.byWidgetPredicate(
        (Widget widget) =>
            widget is RaisedButton &&
            widget.child is Text &&
            (widget.child as Text).data == 'Ler Mangás',
      );
      await (await tester.press(mangas)).up();
      expect('/mangas', Modular.actualRoute);
    });
    testWidgets('Ir para pagina animes', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(home));
      final animes = find.byWidgetPredicate(
        (Widget widget) =>
            widget is RaisedButton &&
            widget.child is Text &&
            (widget.child as Text).data == 'Assistir Animes',
      );
      await (await tester.press(animes)).up();
      expect('/animes', Modular.actualRoute);
    });
  });
}
