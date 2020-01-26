// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnimeController on _AnimeBase, Store {
  final _$episodiosAtom = Atom(name: '_AnimeBase.episodios');

  @override
  ObservableFuture<List<EpisodioModel>> get episodios {
    _$episodiosAtom.context.enforceReadPolicy(_$episodiosAtom);
    _$episodiosAtom.reportObserved();
    return super.episodios;
  }

  @override
  set episodios(ObservableFuture<List<EpisodioModel>> value) {
    _$episodiosAtom.context.conditionallyRunInAction(() {
      super.episodios = value;
      _$episodiosAtom.reportChanged();
    }, _$episodiosAtom, name: '${_$episodiosAtom.name}_set');
  }

  final _$_AnimeBaseActionController = ActionController(name: '_AnimeBase');

  @override
  void listarEpisodios({bool reversed = false}) {
    final _$actionInfo = _$_AnimeBaseActionController.startAction();
    try {
      return super.listarEpisodios(reversed: reversed);
    } finally {
      _$_AnimeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<EpisodioModel> pesquisar(dynamic res) {
    final _$actionInfo = _$_AnimeBaseActionController.startAction();
    try {
      return super.pesquisar(res);
    } finally {
      _$_AnimeBaseActionController.endAction(_$actionInfo);
    }
  }
}
