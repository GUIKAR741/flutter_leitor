// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ler_controle_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LerControleController on _LerControleBase, Store {
  final _$esconderControleAtom =
      Atom(name: '_LerControleBase.esconderControle');

  @override
  bool get esconderControle {
    _$esconderControleAtom.context.enforceReadPolicy(_$esconderControleAtom);
    _$esconderControleAtom.reportObserved();
    return super.esconderControle;
  }

  @override
  set esconderControle(bool value) {
    _$esconderControleAtom.context.conditionallyRunInAction(() {
      super.esconderControle = value;
      _$esconderControleAtom.reportChanged();
    }, _$esconderControleAtom, name: '${_$esconderControleAtom.name}_set');
  }

  final _$_LerControleBaseActionController =
      ActionController(name: '_LerControleBase');

  @override
  void mudar() {
    final _$actionInfo = _$_LerControleBaseActionController.startAction();
    try {
      return super.mudar();
    } finally {
      _$_LerControleBaseActionController.endAction(_$actionInfo);
    }
  }
}
