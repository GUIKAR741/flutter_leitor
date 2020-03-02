// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_titulo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListagemTitulo on _ListagemTituloBase, Store {
  Computed<List<CapEpModel>> _$listagemComputed;

  @override
  List<CapEpModel> get listagem =>
      (_$listagemComputed ??= Computed<List<CapEpModel>>(() => super.listagem))
          .value;

  final _$listaAtom = Atom(name: '_ListagemTituloBase.lista');

  @override
  ObservableFuture<List<CapEpModel>> get lista {
    _$listaAtom.context.enforceReadPolicy(_$listaAtom);
    _$listaAtom.reportObserved();
    return super.lista;
  }

  @override
  set lista(ObservableFuture<List<CapEpModel>> value) {
    _$listaAtom.context.conditionallyRunInAction(() {
      super.lista = value;
      _$listaAtom.reportChanged();
    }, _$listaAtom, name: '${_$listaAtom.name}_set');
  }

  final _$_isReversedAtom = Atom(name: '_ListagemTituloBase._isReversed');

  @override
  bool get _isReversed {
    _$_isReversedAtom.context.enforceReadPolicy(_$_isReversedAtom);
    _$_isReversedAtom.reportObserved();
    return super._isReversed;
  }

  @override
  set _isReversed(bool value) {
    _$_isReversedAtom.context.conditionallyRunInAction(() {
      super._isReversed = value;
      _$_isReversedAtom.reportChanged();
    }, _$_isReversedAtom, name: '${_$_isReversedAtom.name}_set');
  }

  final _$addListaAsyncAction = AsyncAction('addLista');

  @override
  Future<void> addLista(String key, CapEpModel value, {bool add = false}) {
    return _$addListaAsyncAction
        .run(() => super.addLista(key, value, add: add));
  }

  final _$_ListagemTituloBaseActionController =
      ActionController(name: '_ListagemTituloBase');

  @override
  void listarTitulo() {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction();
    try {
      return super.listarTitulo();
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void iniciaBox() {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction();
    try {
      return super.iniciaBox();
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reversed() {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction();
    try {
      return super.reversed();
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CapEpModel> pesquisar(dynamic res) {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction();
    try {
      return super.pesquisar(res);
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'lista: ${lista.toString()},listagem: ${listagem.toString()}';
    return '{$string}';
  }
}
