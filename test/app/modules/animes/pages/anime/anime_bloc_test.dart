import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_bloc.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AnimesModule());
  AnimeBloc bloc;

  setUp(() {
    bloc = Modular.get<AnimeBloc>(params: {'anime': Titulo()});
  });

  group('AnimeBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AnimeBloc>());
    });
  });
}
