import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_page.dart';

main() {
  setUp(() {
    Modular.init(AppModule());
    Modular.bindModule(HqsModule());
  });
  testWidgets('LerPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestableWidget(LerPage(capitulo: Capitulo(titulo: 'Ler'))));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('Ler');
    expect(titleFinder, findsOneWidget);
  });
}
