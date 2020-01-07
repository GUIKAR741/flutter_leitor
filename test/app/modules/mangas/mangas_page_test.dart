import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/mangas/mangas_page.dart';

main() {
  Modular.init(AppModule());
  Modular.bindModule(MangasModule());
  testWidgets('MangasPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MangasPage(title: 'Mangas')));
    final titleFinder = find.text('Mangas');
    expect(titleFinder, findsOneWidget);
  });
}
