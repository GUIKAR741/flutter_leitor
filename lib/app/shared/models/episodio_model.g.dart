// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodioModelAdapter extends TypeAdapter<EpisodioModel> {
  @override
  final typeId = 2;

  @override
  EpisodioModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodioModel()
      ..titulo = fields[0] as String
      ..link = fields[1] as String
      ..status = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, EpisodioModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.status);
  }
}

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

  final _$statusAtom = Atom(name: '_EpisodioModelBase.status');

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

  final _$_EpisodioModelBaseActionController =
      ActionController(name: '_EpisodioModelBase');

  @override
  void mudarStatus() {
    final _$actionInfo = _$_EpisodioModelBaseActionController.startAction();
    try {
      return super.mudarStatus();
    } finally {
      _$_EpisodioModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
