// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$IStatus on _IStatusBase, Store {
  final _$statusAtom = Atom(name: '_IStatusBase.status');

  @override
  bool get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$_IStatusBaseActionController = ActionController(name: '_IStatusBase');

  @override
  void mudarStatus({bool add = false}) {
    final _$actionInfo = _$_IStatusBaseActionController.startAction();
    try {
      return super.mudarStatus(add: add);
    } finally {
      _$_IStatusBaseActionController.endAction(_$actionInfo);
    }
  }
}
