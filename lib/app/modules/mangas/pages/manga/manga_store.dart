import 'package:leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:leitor/app/shared/util/constants.dart';
import 'package:mobx/mobx.dart';

part 'manga_store.g.dart';

class MangaStore extends _MangaStoreBase with _$MangaStore {}

abstract class _MangaStoreBase extends ListagemTitulo with Store {
  _MangaStoreBase() : super(mangas, mangas);
}
