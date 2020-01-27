import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/utils/listagem_titulo.dart';
import 'package:mobx/mobx.dart';

part 'anime_controller.g.dart';

class AnimeController extends _AnimeBase with _$AnimeController {
  AnimeController(AnimeRepository repo) : super(repo);
}

abstract class _AnimeBase extends ListagemTitulo with Store {
  _AnimeBase(AnimeRepository repo) : super(repo);
}
