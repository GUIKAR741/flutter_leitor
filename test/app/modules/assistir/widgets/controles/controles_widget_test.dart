// import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/assistir/assistir_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  initModules([AppModule(), AssistirModule()]);
  // setUp(() {
  //   AssistirController controller = Modular.get<AssistirController>();
  //   controller.videoPlayerController = VideoPlayerController.network('');
  //   controller.chewieController = ChewieController(
  //     videoPlayerController: controller.videoPlayerControllerTest,
  //   );
  //   // controller.iniciarLink(
  //   //   EpisodioModel(
  //   //     link: 'https://www.org/anime/black-clover/1363674',
  //   //   ),
  //   // );
  // });
  testWidgets('ControlesWidget has message', (WidgetTester tester) async {
    // await tester.pumpWidget(buildTestableWidget(Material(
    //       child: ControlesWidget(
    //     title: 'ABC',
    //   ),
    // )));
    // final textFinder = find.text('ABC');
    // expect(textFinder, findsOneWidget);
  });
}
