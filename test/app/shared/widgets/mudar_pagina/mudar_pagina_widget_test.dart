import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/widgets/mudar_pagina/mudar_pagina_widget.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Mudar Pagina", () {
    Widget testavel;
    String pagina = '';
    setUp(() {
      testavel = Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              RaisedButton(
                child: const Text('X'),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return MudarPaginaWidget(
                        paginas: 10,
                        onPressed: (String i) => pagina = i,
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    });
    tearDown(() {
      testavel = null;
    });
    testWidgets('MudarPaginaWidget tem titulo', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(testavel));

      await tester.tap(find.text('X'));
      await tester.pumpAndSettle();
      final titleFinder = find.text('Mudar Página');

      expect(titleFinder, findsOneWidget);
    });
    testWidgets('MudarPaginaWidget botão fechar', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(testavel));

      await tester.tap(find.text('X'));
      await tester.pumpAndSettle();
      final iconFinder = find.byIcon(Icons.arrow_back);

      await tester.tap(iconFinder);
      await tester.pumpAndSettle();

      final mudarPagina = find
          .byWidgetPredicate((Widget widget) => widget is MudarPaginaWidget);
      expect(mudarPagina, findsNothing);
    });
    testWidgets('MudarPaginaWidget botão muda o testa da pagina',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(testavel));

      await tester.tap(find.text('X'));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('5'));
      expect(pagina, '5');
    });
  });
}
