import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'manga_controller.g.dart';

class MangaController extends _MangaBase with _$MangaController{}

abstract class _MangaBase extends ListagemTitulo with Store {
  _MangaBase() {
    box = Hive.openBox<TituloModel>("mangas");
  }
}
