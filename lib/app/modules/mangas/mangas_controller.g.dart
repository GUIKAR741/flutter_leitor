// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mangas_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MangasController on _MangasBase, Store {
  final _$titulosAtom = Atom(name: '_MangasBase.titulos');

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

  final _$_MangasBaseActionController = ActionController(name: '_MangasBase');

  @override
  void listar({bool refresh = false}) {
    final _$actionInfo = _$_MangasBaseActionController.startAction();
    try {
      return super.listar(refresh: refresh);
    } finally {
      _$_MangasBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TituloModel> pesquisar(dynamic res) {
    final _$actionInfo = _$_MangasBaseActionController.startAction();
    try {
      return super.pesquisar(res);
    } finally {
      _$_MangasBaseActionController.endAction(_$actionInfo);
    }
  }
}
