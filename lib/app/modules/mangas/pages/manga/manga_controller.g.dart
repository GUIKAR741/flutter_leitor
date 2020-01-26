// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MangaController on _MangaBase, Store {
  final _$capitulosAtom = Atom(name: '_MangaBase.capitulos');

  @override
  ObservableFuture<List<CapituloModel>> get capitulos {
    _$capitulosAtom.context.enforceReadPolicy(_$capitulosAtom);
    _$capitulosAtom.reportObserved();
    return super.capitulos;
  }

  @override
  set capitulos(ObservableFuture<List<CapituloModel>> value) {
    _$capitulosAtom.context.conditionallyRunInAction(() {
      super.capitulos = value;
      _$capitulosAtom.reportChanged();
    }, _$capitulosAtom, name: '${_$capitulosAtom.name}_set');
  }

  final _$_MangaBaseActionController = ActionController(name: '_MangaBase');

  @override
  void listarCapitulos({bool reversed = false}) {
    final _$actionInfo = _$_MangaBaseActionController.startAction();
    try {
      return super.listarCapitulos(reversed: reversed);
    } finally {
      _$_MangaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CapituloModel> pesquisar(dynamic res) {
    final _$actionInfo = _$_MangaBaseActionController.startAction();
    try {
      return super.pesquisar(res);
    } finally {
      _$_MangaBaseActionController.endAction(_$actionInfo);
    }
  }
}
