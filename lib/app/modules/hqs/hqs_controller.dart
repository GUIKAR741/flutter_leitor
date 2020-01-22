import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/hqs/repositories/hqs_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'hqs_controller.g.dart';

class HqsController extends _HqsBase with _$HqsController {
  HqsController(HqsRepository repo) : super(repo);

  @override
  void dispose() {
    scroll.dispose();
  }
}

abstract class _HqsBase extends Disposable with Store {
  final HqsRepository _repo;
  final ScrollController scroll = ScrollController();

  _HqsBase(this._repo) {
    listar();
  }

  @observable
  ObservableFuture<List<TituloModel>> titulos;

  @action
  void listar({bool refresh = false}) {
    titulos = null;
    titulos = this._repo.pegarHQS(refresh).asObservable();
  }

  @action
  List<TituloModel> pesquisar(res) {
    List<TituloModel> pesquisa = titulos.value
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : titulos.value;
  }
}
