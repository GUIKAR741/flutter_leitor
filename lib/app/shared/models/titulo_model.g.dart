// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'titulo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TituloModelAdapter extends TypeAdapter<TituloModel> {
  @override
  final int typeId = 0;

  @override
  TituloModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TituloModel(
      link: fields[1] as String?,
      nome: fields[0] as String?,
    )
      ..lista = (fields[2] as Map?)?.cast<String, CapEpModel>()
      ..favorito = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, TituloModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.lista)
      ..writeByte(3)
      ..write(obj.favorito);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TituloModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TituloModel on _TituloModelBase, Store {
  Computed<String?>? _$nomeFormatadoComputed;

  @override
  String? get nomeFormatado =>
      (_$nomeFormatadoComputed ??= Computed<String?>(() => super.nomeFormatado,
              name: '_TituloModelBase.nomeFormatado'))
          .value;

  late final _$nomeAtom = Atom(name: '_TituloModelBase.nome', context: context);

  @override
  String? get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String? value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$linkAtom = Atom(name: '_TituloModelBase.link', context: context);

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

  late final _$descricaoAtom =
      Atom(name: '_TituloModelBase.descricao', context: context);

  @override
  String? get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String? value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  late final _$imagemAtom =
      Atom(name: '_TituloModelBase.imagem', context: context);

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

  late final _$favoritoAtom =
      Atom(name: '_TituloModelBase.favorito', context: context);

  @override
  bool get favorito {
    _$favoritoAtom.reportRead();
    return super.favorito;
  }

  @override
  set favorito(bool value) {
    _$favoritoAtom.reportWrite(value, super.favorito, () {
      super.favorito = value;
    });
  }

  late final _$_TituloModelBaseActionController =
      ActionController(name: '_TituloModelBase', context: context);

  @override
  dynamic setFavorito(bool value) {
    final _$actionInfo = _$_TituloModelBaseActionController.startAction(
        name: '_TituloModelBase.setFavorito');
    try {
      return super.setFavorito(value);
    } finally {
      _$_TituloModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
link: ${link},
descricao: ${descricao},
imagem: ${imagem},
favorito: ${favorito},
nomeFormatado: ${nomeFormatado}
    ''';
  }
}
