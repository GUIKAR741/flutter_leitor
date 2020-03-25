import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_page.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  initModules([AppModule(), MangasModule()]);
  testWidgets('MangaPage has title', (WidgetTester tester) async {
    Modular.arguments(
      data: TituloModel(
        nome: 'MangaTeste',
        link: 'http://',
        imagem: '',
        descricao: '',
      ),
    );
    await tester.pumpWidget(
      buildTestableWidget(
        MangaPage(
        ),
      ),
    );
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('MangaTeste');
    expect(titleFinder, findsOneWidget);
  });
}
