import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/pages/hq/hq_controller.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/utils/ler.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'ler_controller.g.dart';

class LerController extends _LerBase with _$LerController {
  LerController(HqRepository repo) : super(repo);
}

abstract class _LerBase extends Ler with Store {
  final HqRepository _repo;

  _LerBase(this._repo) : super(Modular.get<HqController>());

  @override
  @action
  void listarImagens() {
    icone = Icons.pause;
    pagina = '';
    imagens = null;
    paginacao = true;
    _repo.imagens(capitulo.link).then((data) {
      index = 0;
      imagens = data
          .map((String i) => PaginaImagemWidget(url: i))
          .toList()
          .asObservable();
      pagina = "${index + 1}/${imagens.length}";
    });
  }
}
