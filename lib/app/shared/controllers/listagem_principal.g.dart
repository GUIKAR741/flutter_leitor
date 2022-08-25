// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_principal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListagemPrincipal on _ListagemPrincipalBase, Store {
  late final _$titulosAtom =
      Atom(name: '_ListagemPrincipalBase.titulos', context: context);

  @override
  ObservableFuture<List<TituloModel>?>? get titulos {
    _$titulosAtom.reportRead();
    return super.titulos;
  }

  @override
  set titulos(ObservableFuture<List<TituloModel>?>? value) {
    _$titulosAtom.reportWrite(value, super.titulos, () {
      super.titulos = value;
    });
  }

  late final _$iniciaBoxAsyncAction =
      AsyncAction('_ListagemPrincipalBase.iniciaBox', context: context);

  @override
  Future<void> iniciaBox() {
    return _$iniciaBoxAsyncAction.run(() => super.iniciaBox());
  }

  late final _$addFavoritoAsyncAction =
      AsyncAction('_ListagemPrincipalBase.addFavorito', context: context);

  @override
  Future<void> addFavorito(TituloModel titulo) {
    return _$addFavoritoAsyncAction.run(() => super.addFavorito(titulo));
  }

  late final _$_ListagemPrincipalBaseActionController =
      ActionController(name: '_ListagemPrincipalBase', context: context);

  @override
  void listar({bool refresh = false}) {
    final _$actionInfo = _$_ListagemPrincipalBaseActionController.startAction(
        name: '_ListagemPrincipalBase.listar');
    try {
      return super.listar(refresh: refresh);
    } finally {
      _$_ListagemPrincipalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TituloModel>? pesquisar(dynamic res) {
    final _$actionInfo = _$_ListagemPrincipalBaseActionController.startAction(
        name: '_ListagemPrincipalBase.pesquisar');
    try {
      return super.pesquisar(res);
    } finally {
      _$_ListagemPrincipalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
titulos: ${titulos}
    ''';
  }
}
