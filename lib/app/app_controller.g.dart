// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppBase, Store {
  final _$temaAtom = Atom(name: '_AppBase.tema');

  @override
  bool get tema {
    _$temaAtom.context.enforceReadPolicy(_$temaAtom);
    _$temaAtom.reportObserved();
    return super.tema;
  }

  @override
  set tema(bool value) {
    _$temaAtom.context.conditionallyRunInAction(() {
      super.tema = value;
      _$temaAtom.reportChanged();
    }, _$temaAtom, name: '${_$temaAtom.name}_set');
  }

  final _$mudarTemaAsyncAction = AsyncAction('mudarTema');

  @override
  Future mudarTema() {
    return _$mudarTemaAsyncAction.run(() => super.mudarTema());
  }

  @override
  String toString() {
    final string = 'tema: ${tema.toString()}';
    return '{$string}';
  }
}
