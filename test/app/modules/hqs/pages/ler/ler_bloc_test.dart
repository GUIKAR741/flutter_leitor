import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/modules/hqs/hqs_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HqsModule());
  LerBloc bloc;

  setUp(() {
    bloc = HqsModule.to.get<LerBloc>();
  });

  group('LerBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<LerBloc>());
    });
  });
}
