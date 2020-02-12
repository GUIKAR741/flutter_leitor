import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_leitor/app/shared/auth/auth_controller.dart';
import 'package:flutter_leitor/app/app_module.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initModule(AppModule());
  AuthController auth;

  setUp(() {
    auth = AppModule.to.get<AuthController>();
  });

  group('AuthController Test', () {
    test("First Test", () {
      expect(auth, isInstanceOf<AuthController>());
    });
  });
}
