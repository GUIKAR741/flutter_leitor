import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_bloc.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Modular.init(AppModule());
  Modular.bindModule(HqsModule());
  HqsBloc bloc;

  setUp(() {
    bloc = Modular.get<HqsBloc>();
  });

  group('HqsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<HqsBloc>());
    });
  });
}
