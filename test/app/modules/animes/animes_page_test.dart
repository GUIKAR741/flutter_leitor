import 'package:dio/dio.dart';
// import 'package:flutter_leitor/app/app_module.dart';
// import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
// import 'package:flutter_leitor/app/modules/animes/animes_module.dart';
// import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_bloc.dart';
// import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
// import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_modular/flutter_modular_test.dart';

// import 'package:flutter_leitor/app/modules/animes/animes_page.dart';
import 'package:mockito/mockito.dart';

class MockR extends Mock implements AnimesRepository {}
class MockDio extends Mock implements Dio {}

main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  // Modular.init(AppModule());
  // MockDio client = MockDio();
  // Modular.init(AnimesModule());
  // initModule(AnimesModule(), changeBinds: [
  //   Bind((i) => AnimeRepository(i.get<MockDio>())),
  //   Bind((i) => AnimeBloc(i.get<AnimeRepository>())),
  //   Bind((i) => AnimesRepository(i.get<MockDio>())),
  //   Bind((i) => AnimesBloc(i.get<AnimesRepository>())),
  //   Bind((i) => client),
  // ]);
  // TODO Fazer essa merda de teste
  testWidgets('AnimesPage has title', (WidgetTester tester) async {
    // when(client.get("https://leitor-mangas-flutter.firebaseio.com/dados/animes.json"))
    //       .thenAnswer(
    //           (_) async => Response(data: {"id": [{"nome": "", "link": "", "imagem": ""}]}, statusCode: 200));
    // await tester.pumpWidget(buildTestableWidget(AnimesPage(title: 'Animes')));
    // await tester.pump(Duration(minutes: 2));
    // final titleFinder = find.text('Animes');
    // expect(titleFinder, findsOneWidget);
  });
}
