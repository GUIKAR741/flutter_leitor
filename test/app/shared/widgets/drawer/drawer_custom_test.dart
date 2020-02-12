import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/shared/widgets/drawer/drawer_custom.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  initModule(AppModule(), initialModule: true);
  testWidgets('Drawer has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(DrawerCustom()));
    final textFinder = find.text('Inicio');
    expect(textFinder, findsOneWidget);
  });
}
