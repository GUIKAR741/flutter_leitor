import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
// import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_modular/flutter_modular_test.dart';
// import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_page.dart';

main() {
  Modular.init(AppModule());
  Modular.bindModule(MangasModule());

  testWidgets('MangaPage has title', (WidgetTester tester) async {
    // await tester.pumpWidget(buildTestableWidget(MangaPage(manga: Titulo(nome: 'ABC'))));
    // final titleFinder = find.text('ABC');
    // expect(titleFinder, findsOneWidget);
  });
}
