import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_page.dart';

main() {
  Modular.init(AppModule());
  Modular.bindModule(AppModule());
  Modular.bindModule(AnimesModule());
  testWidgets('AnimePage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AnimePage(anime: Titulo(nome: 'Anime'))));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('Anime');
    expect(titleFinder, findsOneWidget);
  });
}
