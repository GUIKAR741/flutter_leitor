import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/app_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Modular.init(AppModule());
  Modular.bindModule(AppModule());
  AppBloc bloc;

  setUp(() {
    bloc = Modular.get<AppBloc>();
  });

  group('AppBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AppBloc>());
    });
  });
}
