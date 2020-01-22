// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodio_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EpisodioModel on _EpisodioModelBase, Store {
  final _$tituloAtom = Atom(name: '_EpisodioModelBase.titulo');

  @override
  String get titulo {
    _$tituloAtom.context.enforceReadPolicy(_$tituloAtom);
    _$tituloAtom.reportObserved();
    return super.titulo;
  }

  @override
  set titulo(String value) {
    _$tituloAtom.context.conditionallyRunInAction(() {
      super.titulo = value;
      _$tituloAtom.reportChanged();
    }, _$tituloAtom, name: '${_$tituloAtom.name}_set');
  }

  final _$linkAtom = Atom(name: '_EpisodioModelBase.link');

  @override
  String get link {
    _$linkAtom.context.enforceReadPolicy(_$linkAtom);
    _$linkAtom.reportObserved();
    return super.link;
  }

  @override
  set link(String value) {
    _$linkAtom.context.conditionallyRunInAction(() {
      super.link = value;
      _$linkAtom.reportChanged();
    }, _$linkAtom, name: '${_$linkAtom.name}_set');
  }

  final _$infoAtom = Atom(name: '_EpisodioModelBase.info');

  @override
  String get info {
    _$infoAtom.context.enforceReadPolicy(_$infoAtom);
    _$infoAtom.reportObserved();
    return super.info;
  }

  @override
  set info(String value) {
    _$infoAtom.context.conditionallyRunInAction(() {
      super.info = value;
      _$infoAtom.reportChanged();
    }, _$infoAtom, name: '${_$infoAtom.name}_set');
  }

  final _$imagemAtom = Atom(name: '_EpisodioModelBase.imagem');

  @override
  String get imagem {
    _$imagemAtom.context.enforceReadPolicy(_$imagemAtom);
    _$imagemAtom.reportObserved();
    return super.imagem;
  }

  @override
  set imagem(String value) {
    _$imagemAtom.context.conditionallyRunInAction(() {
      super.imagem = value;
      _$imagemAtom.reportChanged();
    }, _$imagemAtom, name: '${_$imagemAtom.name}_set');
  }
}
