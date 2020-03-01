import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../controllers/firestore_controller.dart';
import '../interfaces/repository_unique.dart';
import '../models/capitulo_episodio_model.dart';
import '../models/titulo_model.dart';

part 'listagem_titulo.g.dart';

class ListagemTitulo extends _ListagemTituloBase with _$ListagemTitulo {
  @override
  @mustCallSuper
  Future<void> dispose() async {
    scroll.dispose();
    if (!_cancel.isCancelled) _cancel.cancel();
    await (await box)?.close();
  }
}

abstract class _ListagemTituloBase extends Disposable with Store {
  final IRepositoryUnique _repo = Modular.get<IRepositoryUnique>();
  final ScrollController scroll = ScrollController();
  final CancelToken _cancel = CancelToken();
  final FirestoreController _firestoreController =
      Modular.get<FirestoreController>();

  Future<Box<TituloModel>> _box;
  TituloModel _titulo;
  String _colecao;

  @protected
  set colecao(String value) => _colecao = value;
  @protected
  IRepositoryUnique get repo => _repo;
  @protected
  CancelToken get cancel => _cancel;

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
    lista = _repo.listarTitulo(_titulo, cancel: _cancel).asObservable();
    iniciaBox();
  }

  @action
  iniciaBox() async {
    Box<TituloModel> boxHive = (await _box);
    titulo.lista = boxHive.containsKey(titulo.nome.replaceAll('.', '').replaceAll('/', ''))
        ? (await _box).get(titulo.nome.replaceAll('.', '').replaceAll('/', '')).lista
        : <String, CapEpModel>{};
    final Future<void> copiarDadosNuvem = _firestoreController.copiarDadosNuvem(
      colecao: _colecao,
      titulo: titulo,
      box: boxHive,
    );
    lista.whenComplete(
      () async {
        await copiarDadosNuvem;
        if (boxHive.containsKey(titulo.nome.replaceAll('.', '').replaceAll('/', ''))) {
          if (titulo.lista.isNotEmpty) {
            for (CapEpModel i in lista.value) {
              if (titulo.lista.containsKey(i.titulo.replaceAll('.', '').replaceAll('/', '')))
                i.status = titulo.lista[i.titulo.replaceAll('.', '').replaceAll('/', '')].status;
            }
          }
        }
        _firestoreController
            .copiarDadosParaNuvem(
          colecao: _colecao,
          titulo: titulo,
          box: boxHive,
        )
            .whenComplete(() async {
          await boxHive.put(titulo.nome.replaceAll('.', '').replaceAll('/', ''), titulo);
        });
      },
    );
  }

  @action
  addLista(String key, CapEpModel value, {bool add = false}) async {
    value.mudarStatus(add: add);
    titulo.addLista(key.replaceAll('.', '').replaceAll('/', ''), value, add: add);
    Box<TituloModel> boxHive = (await _box);
    _firestoreController.atualizarDados(
      colecao: _colecao,
      titulo: titulo,
      value: value,
    );
    boxHive.put(titulo.nome.replaceAll('.', '').replaceAll('/', ''), titulo);
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
    if (pesquisa?.length == null) return [];
    return pesquisa.length > 0 ? pesquisa : lista.value;
  }
}
