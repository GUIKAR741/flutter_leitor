import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hq_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'hq_controller.g.dart';

class HqController extends _HqBase with _$HqController {
  HqController(HqRepository repo) : super(repo);

  @override
  void dispose() {
    scroll.dispose();
  }
}

abstract class _HqBase extends Disposable with Store {
  final HqRepository _repo;
  final ScrollController scroll = ScrollController();

  _HqBase(this._repo);

  TituloModel _hq;
  @observable
  ObservableFuture<List<CapituloModel>> capitulos;
  bool _isReversed = false;

  set hq(TituloModel value) => _hq = value;

  @action
  void listarCapitulos() {
    capitulos = null;
    capitulos = _repo.capitulos(_hq).asObservable();
  }

  @action
  void inverterCapitulos() {
    capitulos = null;
    capitulos = _repo.capitulos(_hq).then((List<CapituloModel> data) {
      _isReversed = !_isReversed;
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
