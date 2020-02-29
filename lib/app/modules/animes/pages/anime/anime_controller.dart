import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/listagem_titulo.dart';
import '../../../../shared/models/titulo_model.dart';

part 'anime_controller.g.dart';

class AnimeController = _AnimeBase with _$AnimeController;

abstract class _AnimeBase extends ListagemTitulo with Store {
  _AnimeBase() {
    box = Hive.openBox<TituloModel>("animes");
    colecao = "animes";
  }
}
