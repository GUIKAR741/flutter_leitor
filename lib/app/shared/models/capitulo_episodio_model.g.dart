// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capitulo_episodio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CapEpModelAdapter extends TypeAdapter<CapEpModel> {
  @override
  final int typeId = 1;

  @override
  CapEpModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CapEpModel(
      titulo: fields[0] as String?,
      link: fields[1] as String?,
    );
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CapEpModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CapEpModel on _CapEpModelBase, Store {
  Computed<String?>? _$tituloFormatadoComputed;

  @override
  String? get tituloFormatado => (_$tituloFormatadoComputed ??=
          Computed<String?>(() => super.tituloFormatado,
              name: '_CapEpModelBase.tituloFormatado'))
      .value;

  late final _$tituloAtom =
      Atom(name: '_CapEpModelBase.titulo', context: context);

  @override
  String? get titulo {
    _$tituloAtom.reportRead();
    return super.titulo;
  }

  @override
  set titulo(String? value) {
    _$tituloAtom.reportWrite(value, super.titulo, () {
      super.titulo = value;
    });
  }

  late final _$linkAtom = Atom(name: '_CapEpModelBase.link', context: context);

  @override
  String? get link {
    _$linkAtom.reportRead();
    return super.link;
  }

  @override
  set link(String? value) {
    _$linkAtom.reportWrite(value, super.link, () {
      super.link = value;
    });
  }

  late final _$infoAtom = Atom(name: '_CapEpModelBase.info', context: context);

  @override
  String? get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(String? value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  late final _$imagemAtom =
      Atom(name: '_CapEpModelBase.imagem', context: context);

  @override
  String? get imagem {
    _$imagemAtom.reportRead();
    return super.imagem;
  }

  @override
  set imagem(String? value) {
    _$imagemAtom.reportWrite(value, super.imagem, () {
      super.imagem = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_CapEpModelBase.status', context: context);

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$_CapEpModelBaseActionController =
      ActionController(name: '_CapEpModelBase', context: context);

  @override
  void mudarStatus({bool add = false}) {
    final _$actionInfo = _$_CapEpModelBaseActionController.startAction(
        name: '_CapEpModelBase.mudarStatus');
    try {
      return super.mudarStatus(add: add);
    } finally {
      _$_CapEpModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
titulo: ${titulo},
link: ${link},
info: ${info},
imagem: ${imagem},
status: ${status},
tituloFormatado: ${tituloFormatado}
    ''';
  }
}
