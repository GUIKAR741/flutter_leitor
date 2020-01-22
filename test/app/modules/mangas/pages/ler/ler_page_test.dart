import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_page.dart';

main() {
  initModules([AppModule(), MangasModule()]);
  testWidgets('LerPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LerPage(
      capitulo: CapituloModel(titulo: 'LER'),
    )));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('LER');
    expect(titleFinder, findsOneWidget);
  });
}
