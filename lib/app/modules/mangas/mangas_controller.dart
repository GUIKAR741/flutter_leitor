import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'mangas_controller.g.dart';

class MangasController extends _MangasBase with _$MangasController {
  MangasController(MangasRepository repo) : super(repo);

  @override
  void dispose() {
    scroll.dispose();
  }
}

abstract class _MangasBase extends Disposable with Store {
  final MangasRepository _repo;
  final ScrollController scroll = ScrollController();

  _MangasBase(this._repo) {
    listar();
  }

  @observable
  ObservableFuture<List<TituloModel>> titulos;

  @action
  void listar({bool refresh = false}) {
    titulos = null;
    titulos = this._repo.pegarMangas(refresh).asObservable();
  }

  @action
  List<TituloModel> pesquisar(res) {
    List<TituloModel> pesquisa = titulos.value
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : titulos.value;
  }
}
