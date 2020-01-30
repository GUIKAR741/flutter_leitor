import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_principal.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'listagem_principal.g.dart';

abstract class ListagemPrincipal extends _ListagemPrincipalBase
    with _$ListagemPrincipal {
  ListagemPrincipal(RepositoryPrincipal repo) : super(repo);

  @override
  @mustCallSuper
  void dispose() {
    scroll.dispose();
  }
}

abstract class _ListagemPrincipalBase extends Disposable with Store {
  final RepositoryPrincipal _repo;
  final ScrollController scroll = ScrollController();

  @observable
  ObservableFuture<List<TituloModel>> titulos;

  _ListagemPrincipalBase(this._repo) {
    listar();
  }

  @action
  void listar({bool refresh = false}) {
    titulos = null;
    titulos = this._repo.pegarListagem(refresh: refresh).asObservable();
  }

  @action
  List<TituloModel> pesquisar(res) {
    List<TituloModel> pesquisa = titulos.value
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : titulos.value;
  }
}
