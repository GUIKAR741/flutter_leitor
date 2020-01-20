import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/ler/ler_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(MangasModule());
  LerBloc bloc;

  setUp(() {
    bloc = Modular.get<LerBloc>();
  });

  group('LerBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<LerBloc>());
    });
  });
}
