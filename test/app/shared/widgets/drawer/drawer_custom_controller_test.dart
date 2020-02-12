import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/shared/widgets/drawer/drawer_custom_controller.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initModule(AppModule());
  DrawerCustomController drawer;

  setUp(() {
    drawer = DrawerCustomController();
  });

  group('DrawerCustomController Test', () {
    test("First Test", () {
      expect(drawer, isInstanceOf<DrawerCustomController>());
    });
  });
}
