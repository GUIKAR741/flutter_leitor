import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_bloc.dart';
import 'package:flutter_leitor/app/modules/mangas/mangas_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(MangasModule());
  MangaBloc bloc;

  setUp(() {
    bloc = MangasModule.to.get<MangaBloc>({'manga': Titulo()});
  });

  group('MangaBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<MangaBloc>());
    });
  });
}
