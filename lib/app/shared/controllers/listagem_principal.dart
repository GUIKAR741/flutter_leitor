import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'listagem_principal.g.dart';

abstract class ListagemPrincipal extends _ListagemPrincipalBase
    with _$ListagemPrincipal {
  @override
  @mustCallSuper
  void dispose() {
    scroll.dispose();
    if (!_cancel.isCancelled) _cancel.cancel();
  }
}

abstract class _ListagemPrincipalBase extends Disposable with Store {
  final IRepositoryPrincipal _repo = Modular.get<IRepositoryPrincipal>();
  final ScrollController scroll = ScrollController();
  final CancelToken _cancel = CancelToken();

  @observable
  ObservableFuture<List<TituloModel>> titulos;

  _ListagemPrincipalBase() {
    listar();
  }

  @action
  void listar({bool refresh = false}) {
    titulos = null;
    titulos = this
        ._repo
        .pegarListagem(refresh: refresh, cancel: _cancel)
        .asObservable();
  }

  @action
  List<TituloModel> pesquisar(res) {
    List pesquisa = titulos.value is List
        ? titulos.value
            .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
            .toList()
        : [];
    if (pesquisa?.length == null) return [];
    return pesquisa.length > 0 ? pesquisa : titulos.value;
  }
}
