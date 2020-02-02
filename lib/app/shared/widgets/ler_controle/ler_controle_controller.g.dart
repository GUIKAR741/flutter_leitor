// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ler_controle_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LerControleController on _LerControleBase, Store {
  final _$mostrarControleAtom = Atom(name: '_LerControleBase.mostrarControle');

  @override
  bool get mostrarControle {
    _$mostrarControleAtom.context.enforceReadPolicy(_$mostrarControleAtom);
    _$mostrarControleAtom.reportObserved();
    return super.mostrarControle;
  }

  @override
  set mostrarControle(bool value) {
    _$mostrarControleAtom.context.conditionallyRunInAction(() {
      super.mostrarControle = value;
      _$mostrarControleAtom.reportChanged();
    }, _$mostrarControleAtom, name: '${_$mostrarControleAtom.name}_set');
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
