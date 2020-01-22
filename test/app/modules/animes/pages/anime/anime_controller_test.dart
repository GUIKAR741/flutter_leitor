import 'package:flutter_leitor/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_leitor/app/modules/animes/pages/anime/anime_controller.dart';
import 'package:flutter_leitor/app/modules/animes/animes_module.dart';

void main() {
  initModules([AppModule(), AnimesModule()]);
  AnimeController anime;

  setUp(() {
    anime = AnimesModule.to.get<AnimeController>();
  });

  group('AnimeController Test', () {
    test("First Test", () {
      expect(anime, isInstanceOf<AnimeController>());
    });
  });
}
