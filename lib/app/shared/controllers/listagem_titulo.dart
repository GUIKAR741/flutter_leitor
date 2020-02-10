import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/interfaces/repository_unique.dart';
import 'package:flutter_leitor/app/shared/interfaces/status.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'listagem_titulo.g.dart';

class ListagemTitulo extends _ListagemTituloBase with _$ListagemTitulo {
  @override
  @mustCallSuper
  Future<void> dispose() async {
    scroll.dispose();
    await (await box)?.close();
  }
}

abstract class _ListagemTituloBase extends Disposable with Store {
  final IRepositoryUnique _repo = Modular.get<IRepositoryUnique>();
  final ScrollController scroll = ScrollController();

  Future<Box<TituloModel>> _box;
  TituloModel _titulo;

  @observable
  ObservableFuture<List> lista;
  @observable
  bool _isReversed = false;

  TituloModel get titulo => _titulo;
  @protected
  set titulo(TituloModel value) => _titulo = value;
  bool get isReversed => _isReversed;

  @protected
  Future<Box<TituloModel>> get box => _box;
  @protected
  set box(Future<Box<TituloModel>> value) => _box = value;

  @action
  void listarTitulo() {
    titulo = Modular.args.data;
    lista = null;
    _isReversed = false;
    lista = _repo.listarTitulo(_titulo).asObservable();
    iniciaBox();
  }

  @action
  iniciaBox() async {
    Box<TituloModel> boxHive = (await _box);
    lista.whenComplete(
      () {
        if (boxHive.containsKey(titulo.nome)) {
          titulo.lista = boxHive.get(titulo.nome).lista;
          if (titulo.lista.isNotEmpty) {
            for (IStatus i in lista.value) {
              if (titulo.lista.containsKey(i.titulo)) i.status = true;
            }
          }
        }
      },
    );
  }

  @action
  addLista(String key, IStatus value, {bool add = false}) async {
    value.mudarStatus(add: add);
    titulo.addLista(key, value, add: add);
    Box<TituloModel> boxHive = (await _box);
    boxHive.put(titulo.nome, titulo);
  }

  @computed
  List get listagem =>
      !isReversed ? lista.value : lista.value.reversed.toList();

  @action
  void reversed() => _isReversed = !_isReversed;

  @action
  List pesquisar(res) {
    List pesquisa = lista.value is List
        ? lista.value
            .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
            .toList()
        : [];
    return pesquisa.length > 0 ? pesquisa : lista.value;
  }
}
