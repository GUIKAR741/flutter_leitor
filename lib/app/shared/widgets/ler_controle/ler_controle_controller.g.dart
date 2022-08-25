// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ler_controle_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LerControleController on _LerControleBase, Store {
  late final _$esconderControleAtom =
      Atom(name: '_LerControleBase.esconderControle', context: context);

  @override
  bool get esconderControle {
    _$esconderControleAtom.reportRead();
    return super.esconderControle;
  }

  @override
  set esconderControle(bool value) {
    _$esconderControleAtom.reportWrite(value, super.esconderControle, () {
      super.esconderControle = value;
    });
  }

  late final _$_LerControleBaseActionController =
      ActionController(name: '_LerControleBase', context: context);

  @override
  void mudar() {
    final _$actionInfo = _$_LerControleBaseActionController.startAction(
        name: '_LerControleBase.mudar');
    try {
      return super.mudar();
    } finally {
      _$_LerControleBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
esconderControle: ${esconderControle}
    ''';
  }
}
