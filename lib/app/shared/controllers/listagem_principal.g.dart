// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_principal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListagemPrincipal on _ListagemPrincipalBase, Store {
  final _$titulosAtom = Atom(name: '_ListagemPrincipalBase.titulos');

  @override
  ObservableFuture<List<TituloModel>> get titulos {
    _$titulosAtom.context.enforceReadPolicy(_$titulosAtom);
    _$titulosAtom.reportObserved();
    return super.titulos;
  }

  @override
  set titulos(ObservableFuture<List<TituloModel>> value) {
    _$titulosAtom.context.conditionallyRunInAction(() {
      super.titulos = value;
      _$titulosAtom.reportChanged();
    }, _$titulosAtom, name: '${_$titulosAtom.name}_set');
  }

  final _$addFavoritoAsyncAction = AsyncAction('addFavorito');

  @override
  Future<void> addFavorito(TituloModel titulo) {
    return _$addFavoritoAsyncAction.run(() => super.addFavorito(titulo));
  }

  final _$_ListagemPrincipalBaseActionController =
      ActionController(name: '_ListagemPrincipalBase');

  @override
  void listar({bool refresh = false}) {
    final _$actionInfo = _$_ListagemPrincipalBaseActionController.startAction();
    try {
      return super.listar(refresh: refresh);
    } finally {
      _$_ListagemPrincipalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void iniciaBox() {
    final _$actionInfo = _$_ListagemPrincipalBaseActionController.startAction();
    try {
      return super.iniciaBox();
    } finally {
      _$_ListagemPrincipalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TituloModel> pesquisar(dynamic res) {
    final _$actionInfo = _$_ListagemPrincipalBaseActionController.startAction();
    try {
      return super.pesquisar(res);
    } finally {
      _$_ListagemPrincipalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'titulos: ${titulos.toString()}';
    return '{$string}';
  }
}
