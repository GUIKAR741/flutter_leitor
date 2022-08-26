import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:leitor/app/shared/controllers/auth_controller.dart';
import 'package:leitor/app/shared/controllers/firestore_controller.dart';
import 'package:leitor/app/shared/interfaces/repository_unique.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/models/titulo_model.dart';
import 'package:mobx/mobx.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

part 'listagem_titulo.g.dart';

class ListagemTitulo extends _ListagemTituloBase with _$ListagemTitulo {
  ListagemTitulo(String nomeBox, String? colecao) : super(nomeBox, colecao);
}

abstract class _ListagemTituloBase extends Disposable with Store {
  final IRepositoryUnique _repo = Modular.get();
  final AutoScrollController scroll = AutoScrollController(
    axis: Axis.vertical,
  );
  final CancelToken _cancel = CancelToken();
  final AuthController? authController =
      (kIsWeb || !Platform.isLinux) ? Modular.get() : null;
  final FirestoreController? _firestoreController =
      (kIsWeb || !Platform.isLinux) ? Modular.get() : null;

  final String nomeBox;
  Box<TituloModel>? _box;
  TituloModel? _titulo;
  final String? _colecao;

  _ListagemTituloBase(this.nomeBox, this._colecao);

  @protected
  IRepositoryUnique get repo => _repo;

  @protected
  CancelToken get cancel => _cancel;

  @observable
  ObservableFuture<List<CapEpModel>>? lista;
  @observable
  bool _isReversed = false;

  TituloModel? get titulo => _titulo;

  @protected
  set titulo(TituloModel? value) => _titulo = value;

  bool get isReversed => _isReversed;

  @protected
  Box<TituloModel>? get box => _box;

  @protected
  set box(Box<TituloModel>? value) => _box = value;

  @action
  void listarTitulo({bool? refresh}) {
    titulo = Modular.args.data;
    lista = null;
    _isReversed = false;
    // scroll.jumpTo(0);
    lista = _repo
        .listarTitulo(
          _titulo!,
          refresh: refresh,
          cancel: _cancel,
        )
        .asObservable();
    iniciaBox();
  }

  @action
  Future<void> iniciaBox() async {
    if (!Hive.isBoxOpen(nomeBox)) {
      await Hive.openBox<TituloModel>(nomeBox);
    }
    _box = Hive.box<TituloModel>(nomeBox);
    lista?.then(
      (List<CapEpModel> data) async {
        titulo?.lista = _box!.containsKey(titulo!.nomeFormatado)
            ? _box!.get(titulo?.nomeFormatado)!.lista
            : <String, CapEpModel>{};
        if (authController?.status == AuthStatus.logged) {
          await _firestoreController?.copiarDadosNuvem(
            colecao: _colecao!,
            titulo: titulo!,
            box: _box!,
          );
        }
        if (_box!.containsKey(titulo?.nomeFormatado)) {
          if (titulo!.lista != null) {
            if (titulo!.lista!.isNotEmpty) {
              CapEpModel i;
              int? ind = 0;
              for (int j = 0; j < lista!.value!.length; j++) {
                i = lista!.value![j];
                if (titulo!.lista!.containsKey(i.tituloFormatado)) {
                  i.status = titulo!.lista![i.tituloFormatado]!.status;
                  if (i.status) {
                    ind = j;
                  }
                }
              }
              scroll.scrollToIndex(ind! + 1,
                  duration: const Duration(seconds: 1));
            } else {
              scroll.scrollToIndex(0);
            }
          }
        } else {
          scroll.scrollToIndex(0);
        }
        if (authController?.status == AuthStatus.logged) {
          _firestoreController
              ?.copiarDadosParaNuvem(
            colecao: _colecao!,
            titulo: titulo!,
            box: _box!,
          )
              .whenComplete(
            () async {
              await _box!.put(titulo?.nomeFormatado, titulo!);
            },
          );
        }
      },
    );
  }

  @action
  Future<void> addLista(
    String key,
    CapEpModel value, {
    bool add = false,
  }) async {
    value.mudarStatus(add: add);
    titulo?.addLista(key, value, add: add);
    if (authController?.status == AuthStatus.logged) {
      _firestoreController?.atualizarDados(
        colecao: _colecao!,
        titulo: titulo!,
        value: value,
      );
    }
    _box!.put(titulo?.nomeFormatado, titulo!);
  }

  @computed
  List<CapEpModel>? get listagem =>
      !isReversed ? lista!.value : lista!.value!.reversed.toList();

  @action
  void reversed() => _isReversed = !_isReversed;

  @action
  List<CapEpModel>? pesquisar(res) {
    if (lista!.value?.length == null) return [];
    List<CapEpModel> pesquisa = lista!.value is List<CapEpModel>
        ? lista!.value!
            .where((t) => t.titulo!.toLowerCase().contains(res.toLowerCase()))
            .toList()
        : [];
    if (pesquisa.isEmpty) return [];
    return pesquisa.isNotEmpty ? pesquisa : lista!.value;
  }

  @override
  @mustCallSuper
  Future<void> dispose() async {
    scroll.dispose();
    if (!_cancel.isCancelled) _cancel.cancel();
  }
}
