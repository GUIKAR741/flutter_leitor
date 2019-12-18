import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';

main() {
  testWidgets('MangasPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MangasPage(title: 'Mangas')));
    final titleFinder = find.text('Mangas');
    expect(titleFinder, findsOneWidget);
  });
}
