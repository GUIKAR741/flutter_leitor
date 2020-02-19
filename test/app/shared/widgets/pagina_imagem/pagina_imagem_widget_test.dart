import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';

main() {
  testWidgets('PaginaImagemWidget has widget extended image',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(PaginaImagemWidget(url: 'http://')));
    final finder = find.byWidgetPredicate((Widget w) => w is ExtendedImage);
    expect(finder, findsOneWidget);
  });
}
