import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(MangasModule());
  MangasBloc bloc;

  setUp(() {
    bloc = MangasModule.to.get<MangasBloc>();
  });

  group('MangasBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<MangasBloc>());
    });
  });
}
