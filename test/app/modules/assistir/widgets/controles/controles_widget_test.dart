// import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
// import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

// import 'package:flutter_leitor/app/modules/assistir/widgets/controles/controles_widget.dart';

main() {
  initModules([AppModule(), AssistirModule()]);
  testWidgets('ControlesWidget has message', (WidgetTester tester) async {
    // ControlesWidget widget = ControlesWidget(title: 'ABC',);
    // await tester.pumpWidget(buildTestableWidget(widget));
    // final textFinder = find.text('ABC');
    // expect(textFinder, findsOneWidget);
  });
}
