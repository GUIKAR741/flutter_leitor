import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'manga_controller.g.dart';

class MangaController extends _MangaBase with _$MangaController {
  MangaController(MangaRepository repo) : super(repo);
}

abstract class _MangaBase extends ListagemTitulo with Store {
  _MangaBase(MangaRepository repo) : super(repo) {
    box = Hive.openBox<TituloModel>("mangas");
  }

  @override
  void dispose() async {
    super.dispose();
    (await box)?.close();
  }
}
