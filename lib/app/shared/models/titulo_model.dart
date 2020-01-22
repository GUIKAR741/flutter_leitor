import 'dart:convert';

import 'package:mobx/mobx.dart';
part 'titulo_model.g.dart';

class TituloModel extends _TituloModelBase with _$TituloModel {
  TituloModel({String imagem, String link, String nome, String descricao = ''})
      : super(nome: nome, descricao: descricao, link: link, imagem: imagem);

  factory TituloModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TituloModel(
        imagem: json['imagem'],
        link: json['link'],
        nome: json['nome'],
        descricao: json['descricao']);
  }

  static List<TituloModel> fromJsonList(List json) {
    if (json == null) return null;
    return json
        .cast<Map<String, dynamic>>()
        .map((i) => TituloModel.fromJson(i))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'nome': this.nome,
        'imagem': this.imagem,
        'link': this.link,
        'descricao': this.descricao,
      };

  factory TituloModel.fromRawJson(String str) =>
      TituloModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

abstract class _TituloModelBase with Store {
  @observable
  String imagem;
  @observable
  String link;
  @observable
  String nome;
  @observable
  String descricao;

  _TituloModelBase({this.imagem, this.link, this.nome, this.descricao = ''});

  @override
  String toString() => nome;

  @override
  operator ==(o) => o.nome == nome && o.imagem == imagem && o.link == link;

  @override
  int get hashCode =>
      nome.hashCode ^ imagem.hashCode ^ link.hashCode ^ descricao.hashCode;
}
