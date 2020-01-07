import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  Modular.init(AppModule());
  Modular.bindModule(AnimesModule());
  testWidgets('AnimesPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AnimesPage(title: 'Animes')));
    final titleFinder = find.text('Animes');
    expect(titleFinder, findsOneWidget);
  });
}
