import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_page.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initModules([AppModule(), HqsModule()]);
  testWidgets('HqPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        HqPage(
          hq: TituloModel(
              nome: 'HQ', link: 'http://', imagem: '', descricao: ''),
        ),
      ),
    );
    await tester.pump(Duration(minutes: 1));
    // await tester.pumpAndSettle();
    final titleFinder = find.text('HQ');
    expect(titleFinder, findsOneWidget);
  });
}
