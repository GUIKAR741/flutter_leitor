import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';
import 'package:hive/hive.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  initModules([AppModule(), MangasModule()]);
  testWidgets('MangasPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MangasPage(title: 'Mangas')));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('Mangas');
    expect(titleFinder, findsOneWidget);
  });
}
