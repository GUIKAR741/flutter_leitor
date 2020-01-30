import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'listagem_titulo.g.dart';

class ListagemTitulo extends _ListagemTituloBase with _$ListagemTitulo {
  ListagemTitulo(RepositoryUnique repo) : super(repo);

  @override
  @mustCallSuper
  void dispose() {
    scroll.dispose();
  }
}

abstract class _ListagemTituloBase extends Disposable with Store {
  final RepositoryUnique _repo;
  final ScrollController scroll = ScrollController();

  TituloModel _titulo;
  @observable
  ObservableFuture<List> lista;
  bool _isReversed = false;

  _ListagemTituloBase(this._repo);

  set titulo(TituloModel value) => _titulo = value;
  bool get isReversed => _isReversed;

  @action
  void listarTitulo({bool reversed = false}) {
    lista = null;
    if (reversed && lista.value != null) {
      if (reversed) _isReversed = !_isReversed;
      lista = Future<List>.value(
        !_isReversed ? lista.value : lista.value.reversed.toList(),
      ).asObservable();
      return;
    }
    lista = _repo.listarTitulo(_titulo).then((List data) {
      if (reversed) _isReversed = !_isReversed;
      return !_isReversed ? data : data.reversed.toList();
    }).asObservable();
  }

  @action
  List pesquisar(res) {
    List pesquisa = lista.value
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : lista.value;
  }
}
