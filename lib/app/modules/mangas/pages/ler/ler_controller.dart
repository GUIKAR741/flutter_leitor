import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/pages/manga/manga_controller.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/controllers/ler.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'ler_controller.g.dart';

class LerController extends _LerBase with _$LerController {
  LerController(MangaRepository _repo) : super(_repo);
}

abstract class _LerBase extends Ler with Store {
  final MangaRepository _repo;

  _LerBase(this._repo) : super(Modular.get<MangaController>());

  @override
  @action
  void listarImagens() {
    icone = Icons.pause;
    pagina = '';
    imagens = null;
    paginacao = true;
    imagens = _repo.imagens(capitulo.link).then((data) {
      index = 0;
      pagina = "${index + 1}/${data.length}";
      return data.map((String i) => PaginaImagemWidget(url: i)).toList();
    }).asObservable();
  }
}
