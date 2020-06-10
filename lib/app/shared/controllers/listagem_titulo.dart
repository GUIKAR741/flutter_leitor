import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
  final AutoScrollController scroll = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0,
          MediaQuery.of(Modular.navigatorKey.currentContext).padding.bottom),
      axis: Axis.vertical);
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
  ObservableFuture<List<CapEpModel>> lista;
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
  void listarTitulo({bool refresh}) {
    titulo = Modular.args.data;
    lista = null;
    _isReversed = false;
    // scroll.jumpTo(0);
    lista = _repo
        .listarTitulo(
          _titulo,
          refresh: refresh,
          cancel: _cancel,
        )
        .asObservable();
    iniciaBox();
  }

  @action
  void iniciaBox() {
    lista.then(
      (List<CapEpModel> data) async {
        Box<TituloModel> boxHive = (await _box);
        titulo.lista = boxHive.containsKey(titulo.nomeFormatado)
            ? (await _box).get(titulo.nomeFormatado).lista
            : <String, CapEpModel>{};
        await _firestoreController.copiarDadosNuvem(
          colecao: _colecao,
          titulo: titulo,
          box: boxHive,
        );
        if (boxHive.containsKey(titulo.nomeFormatado)) {
          if (titulo.lista.isNotEmpty) {
            CapEpModel i, ind;
            for (i in lista.value)
              if (titulo.lista.containsKey(i.tituloFormatado)) {
                i.status = titulo.lista[i.tituloFormatado].status;
                ind = i.status ? i : ind;
              }
            if (ind != null)
              scroll.scrollToIndex(lista.value.lastIndexOf(ind) + 1);
          } else
            scroll.scrollToIndex(0);
        } else
          scroll.scrollToIndex(0);
        _firestoreController
            .copiarDadosParaNuvem(
          colecao: _colecao,
          titulo: titulo,
          box: boxHive,
        )
            .whenComplete(
          () async {
            await boxHive.put(titulo.nomeFormatado, titulo);
          },
        );
      },
    );
  }

  @action
  Future<void> addLista(String key, CapEpModel value,
      {bool add = false}) async {
    value.mudarStatus(add: add);
    titulo.addLista(key, value, add: add);
    Box<TituloModel> boxHive = (await _box);
    _firestoreController.atualizarDados(
      colecao: _colecao,
      titulo: titulo,
      value: value,
    );
    boxHive.put(titulo.nomeFormatado, titulo);
  }

  @computed
  List<CapEpModel> get listagem =>
      !isReversed ? lista.value : lista.value.reversed.toList();

  @action
  void reversed() => _isReversed = !_isReversed;

  @action
  List<CapEpModel> pesquisar(res) {
    if (lista.value?.length == null) return [];
    List<CapEpModel> pesquisa = lista.value is List<CapEpModel>
        ? lista.value
            .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
            .toList()
        : [];
    if (pesquisa == null || pesquisa?.length == null) return [];
    return pesquisa?.length != null && pesquisa.length > 0
        ? pesquisa
        : lista.value;
  }
}
