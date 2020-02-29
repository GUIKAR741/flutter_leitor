import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/listagem_titulo.dart';
import '../../../../shared/models/titulo_model.dart';

part 'manga_controller.g.dart';

class MangaController extends _MangaBase with _$MangaController {}

abstract class _MangaBase extends ListagemTitulo with Store {
  _MangaBase() {
    box = Hive.openBox<TituloModel>("mangas");
    colecao = 'mangas';
  }
}
