// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_titulo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListagemTitulo on _ListagemTituloBase, Store {
  final _$listaAtom = Atom(name: '_ListagemTituloBase.lista');

  @override
  ObservableFuture<List<dynamic>> get lista {
    _$listaAtom.context.enforceReadPolicy(_$listaAtom);
    _$listaAtom.reportObserved();
    return super.lista;
  }

  @override
  set lista(ObservableFuture<List<dynamic>> value) {
    _$listaAtom.context.conditionallyRunInAction(() {
      super.lista = value;
      _$listaAtom.reportChanged();
    }, _$listaAtom, name: '${_$listaAtom.name}_set');
  }

  final _$_ListagemTituloBaseActionController =
      ActionController(name: '_ListagemTituloBase');

  @override
  void listarTitulo({bool reversed = false}) {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction();
    try {
      return super.listarTitulo(reversed: reversed);
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<dynamic> pesquisar(dynamic res) {
    final _$actionInfo = _$_ListagemTituloBaseActionController.startAction();
    try {
      return super.pesquisar(res);
    } finally {
      _$_ListagemTituloBaseActionController.endAction(_$actionInfo);
    }
  }
}
