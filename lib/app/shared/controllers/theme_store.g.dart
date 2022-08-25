// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStoreBase, Store {
  late final _$temaValueAtom =
      Atom(name: '_ThemeStoreBase.temaValue', context: context);

  @override
  bool get temaValue {
    _$temaValueAtom.reportRead();
    return super.temaValue;
  }

  @override
  set temaValue(bool value) {
    _$temaValueAtom.reportWrite(value, super.temaValue, () {
      super.temaValue = value;
    });
  }

  late final _$temaBoxAtom =
      Atom(name: '_ThemeStoreBase.temaBox', context: context);

  @override
  Box<bool>? get temaBox {
    _$temaBoxAtom.reportRead();
    return super.temaBox;
  }

  @override
  set temaBox(Box<bool>? value) {
    _$temaBoxAtom.reportWrite(value, super.temaBox, () {
      super.temaBox = value;
    });
  }

  late final _$mudarTemaAsyncAction =
      AsyncAction('_ThemeStoreBase.mudarTema', context: context);

  @override
  Future mudarTema() {
    return _$mudarTemaAsyncAction.run(() => super.mudarTema());
  }

  @override
  String toString() {
    return '''
temaValue: ${temaValue},
temaBox: ${temaBox}
    ''';
  }
}
