import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_page.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp((){
    Modular.init(AppModule());
    Modular.bindModule(HqsModule());
  });
  testWidgets('HqPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(HqPage(hq: Titulo(nome: 'HQ'))));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('HQ');
    expect(titleFinder, findsOneWidget);
  });
}
