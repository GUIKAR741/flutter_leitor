import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_page.dart';

main() {
  Modular.init(AppModule());
  Modular.bindModule(MangasModule());
  testWidgets('LerPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LerPage(
      manga: Titulo(nome: 'Ler'),
      capitulo: Capitulo(titulo: 'Ler', link: ''),
      bloc: MangasModule.to.get<LerBloc>(),
    )));
    await tester.pump(Duration(minutes: 1));
    final titleFinder = find.text('Ler - Ler');
    expect(titleFinder, findsOneWidget);
  });
}
