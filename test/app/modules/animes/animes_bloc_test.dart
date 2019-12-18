import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/animes_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AnimesModule());
  AnimesBloc bloc;

  setUp(() {
    bloc = AnimesModule.to.get<AnimesBloc>();
  });

  group('AnimesBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AnimesBloc>());
    });
  });
}
