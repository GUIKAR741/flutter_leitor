import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../interfaces/repository_principal.dart';
import '../models/titulo_model.dart';

part 'listagem_principal.g.dart';

abstract class ListagemPrincipal extends _ListagemPrincipalBase
    with _$ListagemPrincipal {
  ListagemPrincipal(String boxName) : super(boxName);
}

abstract class _ListagemPrincipalBase extends Disposable with Store {
  final IRepositoryPrincipal _repo = Modular.get();
  final ScrollController scroll = ScrollController();
  final CancelToken _cancel = CancelToken();

  final String boxName;
  Box<TituloModel>? _box;

  @observable
  ObservableFuture<List<TituloModel>?>? titulos;

  @protected
  Box<TituloModel>? get box => _box;

  @protected
  set box(Box<TituloModel>? value) => _box = value;

  _ListagemPrincipalBase(this.boxName) {
    listar();
  }

  @action
  void listar({bool refresh = false}) {
    titulos = null;
    titulos =
        _repo.pegarListagem(refresh: refresh, cancel: _cancel)!.asObservable();
    iniciaBox();
  }

  @action
  Future<void> iniciaBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<TituloModel>(boxName);
    }
    _box = Hive.box<TituloModel>(boxName);
    TituloModel? t;
    titulos?.then((List<TituloModel>? data) async {
      if (data != null) {
        int i = 0;
        for (int j = 0; j < data.length; j++) {
          t = data[j];
          if (_box!.containsKey(t?.nomeFormatado)) {
            t?.favorito = _box!.get(t?.nomeFormatado)!.favorito;
            if (t != null && t!.favorito) {
              data.removeAt(j);
              data.insert(i++, t!);
            }
          }
        }
        return data;
      }
    });
  }

  @action
  List<TituloModel>? pesquisar(res) {
    if (titulos!.value?.length == null) return [];
    List<TituloModel> pesquisa = titulos!.value is List
        ? titulos!.value!
            .where((t) => t.nome!.toLowerCase().contains(res.toLowerCase()))
            .toList()
        : [];
    if (pesquisa.isEmpty) return [];
    return pesquisa.isNotEmpty ? pesquisa : titulos!.value;
  }

  @action
  Future<void> addFavorito(TituloModel titulo) async {
    titulo.setFavorito(!titulo.favorito);
    _box!.put(titulo.nomeFormatado, titulo);
  }

  @override
  @mustCallSuper
  void dispose() {
    scroll.dispose();
    if (!_cancel.isCancelled) _cancel.cancel();
  }
}
