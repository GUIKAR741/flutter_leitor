// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_titulo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListagemTitulo on _ListagemTituloBase, Store {
  Computed<List<CapEpModel>?>? _$listagemComputed;

  @override
  List<CapEpModel>? get listagem =>
      (_$listagemComputed ??= Computed<List<CapEpModel>?>(() => super.listagem,
              name: '_ListagemTituloBase.listagem'))
          .value;

  late final _$listaAtom =
      Atom(name: '_ListagemTituloBase.lista', context: context);

  @override
  ObservableFuture<List<CapEpModel>>? get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableFuture<List<CapEpModel>>? value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  late final _$_isReversedAtom =
      Atom(name: '_ListagemTituloBase._isReversed', context: context);

  @override
  bool get _isReversed {
    _$_isReversedAtom.reportRead();
    return super._isReversed;
  }

  @override
  set _isReversed(bool value) {
    _$_isReversedAtom.reportWrite(value, super._isReversed, () {
      super._isReversed = value;
    });
  }

  late final _$iniciaBoxAsyncAction =
      AsyncAction('_ListagemTituloBase.iniciaBox', context: context);

  @override
  Future<void> iniciaBox() {
    return _$iniciaBoxAsyncAction.run(() => super.iniciaBox());
  }

  late final _$addListaAsyncAction =
      AsyncAction('_ListagemTituloBase.addLista', context: context);

  @override
  Future<void> addLista(String key, CapEpModel value, {bool add = false}) {
    return _$addListaAsyncAction
        .run(() => super.addLista(key, value, add: add));
  }

  late final _$_ListagemTituloBaseActionController =
      ActionController(name: '_ListagemTituloBase', context: context);

  @override
  void listarTitulo({bool? refresh}) {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction(
        name: '_ListagemTituloBase.listarTitulo');
    try {
      return super.listarTitulo(refresh: refresh);
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reversed() {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction(
        name: '_ListagemTituloBase.reversed');
    try {
      return super.reversed();
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CapEpModel>? pesquisar(dynamic res) {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction(
        name: '_ListagemTituloBase.pesquisar');
    try {
      return super.pesquisar(res);
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lista: ${lista},
listagem: ${listagem}
    ''';
  }
}
