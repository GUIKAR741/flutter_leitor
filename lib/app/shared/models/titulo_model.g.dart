// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'titulo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TituloModelAdapter extends TypeAdapter<TituloModel> {
  @override
  final typeId = 0;

  @override
  TituloModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TituloModel()
      ..nome = fields[0] as String
      ..link = fields[1] as String
      ..lista = (fields[2] as Map)?.cast<String, CapEpModel>()
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
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TituloModel on _TituloModelBase, Store {
  Computed<String> _$nomeFormatadoComputed;

  @override
  String get nomeFormatado =>
      (_$nomeFormatadoComputed ??= Computed<String>(() => super.nomeFormatado))
          .value;

  final _$nomeAtom = Atom(name: '_TituloModelBase.nome');

  @override
  String get nome {
    _$nomeAtom.context.enforceReadPolicy(_$nomeAtom);
    _$nomeAtom.reportObserved();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.context.conditionallyRunInAction(() {
      super.nome = value;
      _$nomeAtom.reportChanged();
    }, _$nomeAtom, name: '${_$nomeAtom.name}_set');
  }

  final _$linkAtom = Atom(name: '_TituloModelBase.link');

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

  final _$descricaoAtom = Atom(name: '_TituloModelBase.descricao');

  @override
  String get descricao {
    _$descricaoAtom.context.enforceReadPolicy(_$descricaoAtom);
    _$descricaoAtom.reportObserved();
    return super.descricao;
  }

  @override
  set descricao(String value) {
    _$descricaoAtom.context.conditionallyRunInAction(() {
      super.descricao = value;
      _$descricaoAtom.reportChanged();
    }, _$descricaoAtom, name: '${_$descricaoAtom.name}_set');
  }

  final _$imagemAtom = Atom(name: '_TituloModelBase.imagem');

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

  final _$favoritoAtom = Atom(name: '_TituloModelBase.favorito');

  @override
  bool get favorito {
    _$favoritoAtom.context.enforceReadPolicy(_$favoritoAtom);
    _$favoritoAtom.reportObserved();
    return super.favorito;
  }

  @override
  set favorito(bool value) {
    _$favoritoAtom.context.conditionallyRunInAction(() {
      super.favorito = value;
      _$favoritoAtom.reportChanged();
    }, _$favoritoAtom, name: '${_$favoritoAtom.name}_set');
  }

  final _$_TituloModelBaseActionController =
      ActionController(name: '_TituloModelBase');

  @override
  dynamic setFavorito(bool value) {
    final _$actionInfo = _$_TituloModelBaseActionController.startAction();
    try {
      return super.setFavorito(value);
    } finally {
      _$_TituloModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'nome: ${nome.toString()},link: ${link.toString()},descricao: ${descricao.toString()},imagem: ${imagem.toString()},favorito: ${favorito.toString()},nomeFormatado: ${nomeFormatado.toString()}';
    return '{$string}';
  }
}
