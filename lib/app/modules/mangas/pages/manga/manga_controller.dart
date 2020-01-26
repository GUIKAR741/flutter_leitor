import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'manga_controller.g.dart';

class MangaController extends _MangaBase with _$MangaController {
  MangaController(MangaRepository _repo) : super(_repo);

  @override
  void dispose() {
    scroll.dispose();
  }
}

abstract class _MangaBase extends Disposable with Store {
  final MangaRepository _repo;
  final ScrollController scroll = ScrollController();

  TituloModel _manga;
  @observable
  ObservableFuture<List<CapituloModel>> capitulos;
  bool _isReversed = false;

  _MangaBase(this._repo);

  set manga(TituloModel value) => _manga = value;
  bool get isReversed => _isReversed;

  @action
  void listarCapitulos({bool reversed = false}) {
    capitulos = null;
    capitulos = _repo.capitulos(_manga).then((List<CapituloModel> data) {
      if (reversed) _isReversed = !_isReversed;
      return !_isReversed ? data : data.reversed.toList();
    }).asObservable();
  }

  @action
  List<CapituloModel> pesquisar(res) {
    List<CapituloModel> pesquisa = capitulos.value
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : capitulos.value;
  }
}
