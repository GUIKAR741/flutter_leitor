// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capitulo_episodio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CapEpModelAdapter extends TypeAdapter<CapEpModel> {
  @override
  final typeId = 1;

  @override
  CapEpModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CapEpModel()
      ..titulo = fields[0] as String
      ..link = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, CapEpModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.link);
  }
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CapEpModel on _CapEpModelBase, Store {
  Computed<String> _$tituloFormatadoComputed;

  @override
  String get tituloFormatado => (_$tituloFormatadoComputed ??=
          Computed<String>(() => super.tituloFormatado))
      .value;

  final _$tituloAtom = Atom(name: '_CapEpModelBase.titulo');

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

  final _$linkAtom = Atom(name: '_CapEpModelBase.link');

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

  final _$infoAtom = Atom(name: '_CapEpModelBase.info');

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

  final _$imagemAtom = Atom(name: '_CapEpModelBase.imagem');

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

  final _$statusAtom = Atom(name: '_CapEpModelBase.status');

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

  final _$_CapEpModelBaseActionController =
      ActionController(name: '_CapEpModelBase');

  @override
  void mudarStatus({bool add = false}) {
    final _$actionInfo = _$_CapEpModelBaseActionController.startAction();
    try {
      return super.mudarStatus(add: add);
    } finally {
      _$_CapEpModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'titulo: ${titulo.toString()},link: ${link.toString()},info: ${info.toString()},imagem: ${imagem.toString()},status: ${status.toString()},tituloFormatado: ${tituloFormatado.toString()}';
    return '{$string}';
  }
}
