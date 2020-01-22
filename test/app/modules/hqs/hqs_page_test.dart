import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/hqs/hqs_page.dart';

main() {
  initModules([AppModule(), HqsModule()]);
  testWidgets('HqsPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(HqsPage(title: 'Hqs')));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('Hqs');
    expect(titleFinder, findsOneWidget);
  });
}
