import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_page.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  initModules([AppModule(), AnimesModule()]);
  testWidgets('AnimePage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        AnimePage(
          anime: TituloModel(
            nome: 'AnimeTeste',
            link: 'http://',
            imagem: '',
            descricao: '',
          ),
        ),
      ),
    );
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('AnimeTeste');
    expect(titleFinder, findsOneWidget);
  });
}
