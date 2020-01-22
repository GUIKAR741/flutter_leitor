import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'animes_controller.g.dart';

class AnimesController extends _AnimesBase with _$AnimesController {
  AnimesController(repo) : super(repo);

  @override
  void dispose() {
    scrollController.dispose();
  }
}

abstract class _AnimesBase extends Disposable with Store {
  final AnimesRepository _repo;
  final ScrollController scrollController = ScrollController();

  _AnimesBase(this._repo) {
    listar();
  }

  @observable
  ObservableFuture<List<TituloModel>> titulos;

  @action
  void listar({bool refresh = false}) {
    titulos = null;
    titulos = this._repo.pegarAnimes(refresh).asObservable();
  }

  @action
  List<TituloModel> pesquisar(res) {
    List<TituloModel> pesquisa = titulos.value
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : titulos.value;
  }
}
