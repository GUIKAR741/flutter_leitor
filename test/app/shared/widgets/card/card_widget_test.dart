import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/shared/widgets/card/card_widget.dart';

main() {
  testWidgets('CardWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(CardWidget(
      titulo: TituloModel(descricao: "Card", imagem: ''),
    )));
    final textFinder = find.text('Card');
    expect(textFinder, findsOneWidget);
  });
}
