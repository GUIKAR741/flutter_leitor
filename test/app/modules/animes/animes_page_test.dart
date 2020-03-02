import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/animes/animes_page.dart';
import 'package:hive/hive.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  initModules([AppModule(), AnimesModule()]);
  testWidgets('AnimesPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AnimesPage(title: 'Animes')));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('Animes');
    expect(titleFinder, findsOneWidget);
  });
}
