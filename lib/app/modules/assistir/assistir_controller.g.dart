// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistir_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssistirController on _AssistirBase, Store {
  final _$chewieAtom = Atom(name: '_AssistirBase.chewie');

  @override
  ObservableFuture<Chewie> get chewie {
    _$chewieAtom.context.enforceReadPolicy(_$chewieAtom);
    _$chewieAtom.reportObserved();
    return super.chewie;
  }

  @override
  set chewie(ObservableFuture<Chewie> value) {
    _$chewieAtom.context.conditionallyRunInAction(() {
      super.chewie = value;
      _$chewieAtom.reportChanged();
    }, _$chewieAtom, name: '${_$chewieAtom.name}_set');
  }

  final _$_AssistirBaseActionController =
      ActionController(name: '_AssistirBase');

  @override
  void iniciarLink(EpisodioModel ep) {
    final _$actionInfo = _$_AssistirBaseActionController.startAction();
    try {
      return super.iniciarLink(ep);
    } finally {
      _$_AssistirBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'chewie: ${chewie.toString()}';
    return '{$string}';
  }
}
