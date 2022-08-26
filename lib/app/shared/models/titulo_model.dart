import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:mobx/mobx.dart';

part 'titulo_model.g.dart';

@HiveType(typeId: 0)
class TituloModel extends _TituloModelBase with _$TituloModel {
  TituloModel({
    String? imagem,
    String? link,
    String? nome,
    String? descricao = '',
  }) : super(
          nome: nome,
          descricao: descricao,
          link: link,
          imagem: imagem,
        );

  factory TituloModel.fromJson(Map<String, dynamic> json) {
    return TituloModel(
        imagem: json['imagem'],
        link: json['link'],
        nome: json['nome'],
        descricao: json['descricao']);
  }

  static List<TituloModel>? fromJsonList(List? json) {
    if (json == null) return null;
    return json
        .cast<Map<String, dynamic>>()
        .map((i) => TituloModel.fromJson(i))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'imagem': imagem,
        'link': link,
        'descricao': descricao,
      };

  factory TituloModel.fromRawJson(String str) =>
      TituloModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

abstract class _TituloModelBase extends HiveObject with Store, EquatableMixin {
  @HiveField(0)
  @observable
  String? nome;

  @HiveField(1)
  @observable
  String? link;

  @observable
  String? descricao;

  @observable
  String? imagem;

  @HiveField(2)
  Map<String, CapEpModel>? lista = <String, CapEpModel>{};

  @observable
  @HiveField(3)
  bool favorito = false;

  @action
  setFavorito(bool value) => favorito = value;

  @computed
  String? get nomeFormatado => nome?.replaceAll('.', '').replaceAll('/', '');

  void addLista(String key, CapEpModel value, {bool add = false}) {
    if (lista != null) {
      if (lista!.containsKey(key) && !add) {
        lista!.remove(key);
        return;
      }
      lista![key] = value;
    }
  }

  _TituloModelBase({
    this.imagem,
    this.link,
    this.nome,
    this.descricao,
  });

  @override
  String toString() => nome!;

  @override
  List<Object> get props => [
        nome!,
        imagem!,
        link!,
        descricao!,
      ];
}
