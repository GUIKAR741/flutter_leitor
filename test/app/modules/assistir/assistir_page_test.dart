import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_page.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  initModules([AppModule(), AssistirModule()]);
  testWidgets('AssistirPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        MaterialApp(
          navigatorKey: Modular.navigatorKey,
          home: AssistirPage(
            episodio: EpisodioModel(
              titulo: 'episodio',
              imagem: '',
              link: 'jksdhfksd',
              info: '',
            ),
          ),
        ),
      ),
    );
    await tester.pump(Duration(minutes: 1));
    // final observerFinder = find.byWidgetPredicate((Widget e) => e is Observer);
    // expect(observerFinder, findsOneWidget);
  });
}
