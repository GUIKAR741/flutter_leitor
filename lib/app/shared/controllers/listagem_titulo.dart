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
  @observable
  bool _isReversed = false;

  _ListagemTituloBase(this._repo);

  set titulo(TituloModel value) => _titulo = value;
  bool get isReversed => _isReversed;

  @action
  void listarTitulo() {
    lista = null;
    _isReversed = false;
    lista = _repo.listarTitulo(_titulo).asObservable();
  }

  @computed
  List get listagem =>
      !isReversed ? lista.value : lista.value.reversed.toList();

  @action
  void reversed() => _isReversed = !_isReversed;

  @action
  List pesquisar(res) {
    List pesquisa = lista.value
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : lista.value;
  }
}
