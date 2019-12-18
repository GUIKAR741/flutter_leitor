import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/animes/animes_page.dart';

main() {
  testWidgets('AnimesPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AnimesPage(title: 'Animes')));
    final titleFinder = find.text('Animes');
    expect(titleFinder, findsOneWidget);
  });
}
