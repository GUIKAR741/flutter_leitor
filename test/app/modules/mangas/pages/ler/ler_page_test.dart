import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_page.dart';

main() {
  testWidgets('LerPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LerPage(title: 'Ler')));
    final titleFinder = find.text('Ler');
    expect(titleFinder, findsOneWidget);
  });
}
