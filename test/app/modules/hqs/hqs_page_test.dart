import 'dart:io';

import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_page.dart';
import 'package:flutter_leitor/app/shared/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../../mocks/Dio.dart';

main() {
  Hive.init(Directory.current.path + "/hive");
  initModule(
    AppModule(),
    changeBinds: [
      // Bind<Dio>((i) => DioMock()),
      Bind<DioService>((i) => DioServiceMock()),
    ],
    initialModule: true,
  );
  DioServiceMock dioService = Modular.get<DioService>();
  // DioForNative dio = Modular.get<Dio>();
  // print(dio.runtimeType);
  // print(dioService.runtimeType);
  initModule(HqsModule());
  HqsPage hqs = HqsPage(title: 'Hqs');
  group("HQs Page Tests", () {
    // testWidgets('HqsPage has title', (WidgetTester tester) async {
    //   await tester.pumpWidget(buildTestableWidget(hqs));
    //   await tester.pump(Duration(minutes: 1));
    //   final titleFinder = find.text('Hqs');
    //   expect(titleFinder, findsOneWidget);
    // });
    testWidgets("Has scrollbar", (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(hqs));
      await tester.pump(Duration(minutes: 1));
      // when(
      //   dioService.getLink(
      //     "https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json",
      //   ),
      // ).thenAnswer(
      //   (_) async => Response(data:{
      //     "-M-bwHvDYykbi4XXHOun": {"data": "2020-02-09 03:14:42"}
      //   }, statusCode: 200),
      // );
      dioService.cassette = 'repo/data';
      print(await dioService.client.get(
        "https://leitor-mangas-flutter.firebaseio.com/dados/atualizacao.json",
      ));
      // await Modular.get<HqsController>().titulos;
      // final scroll =
      //     find.byWidgetPredicate((Widget widget) => widget is Scrollbar);
      // print(scroll);
    });
  });
}
