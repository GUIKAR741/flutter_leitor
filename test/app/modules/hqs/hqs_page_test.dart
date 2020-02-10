import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_page.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  initModule(AppModule(), initialModule: true);
  initModule(HqsModule());
  HqsPage hqs = HqsPage(title: 'Hqs');
  group("HQs Page Tests", () {
    testWidgets('HqsPage has title', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(hqs));
      await tester.pump(Duration(minutes: 1));
      final titleFinder = find.text('Hqs');
      expect(titleFinder, findsOneWidget);
    });
  });
}
