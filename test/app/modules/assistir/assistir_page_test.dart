import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/assistir/assistir_page.dart';

main() {
  initModules([AppModule(), AssistirModule()]);
  testWidgets('AssistirPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AssistirPage(
      episodio: EpisodioModel(titulo: 'episodio'),
    )));
    await tester.pump(Duration(minutes: 1));
    // final titleFinder = find.text('Carregando...');
    // expect(titleFinder, findsOneWidget);
  });
}
