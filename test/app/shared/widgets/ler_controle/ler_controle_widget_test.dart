import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/shared/widgets/ler_controle/ler_controle.dart';
import 'package:flutter_leitor/app/shared/widgets/ler_controle/ler_controle_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

main() {
  initModule(AppModule());
  testWidgets('LerControleWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        Material(
          child: LerControle(
            title: Text('LerControle'),
            actions: <Widget>[],
            controller: LerControleController(),
          ),
        ),
      ),
    );
    final textFinder = find.text('LerControle');
    expect(textFinder, findsOneWidget);
  });
}
