import 'dart:convert';

import 'package:mobx/mobx.dart';
part 'episodio_model.g.dart';

class EpisodioModel extends _EpisodioModelBase with _$EpisodioModel {
  EpisodioModel({String titulo, String link, String info, String imagem})
      : super(titulo: titulo, link: link, info: info, imagem: imagem);

  factory EpisodioModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return EpisodioModel(
      titulo: json['titulo'],
      link: json['link'],
      info: json['info'],
      imagem: json['imagem'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titulo': this.titulo,
        'link': this.link,
        'info': this.info,
        'imagem': this.imagem,
      };

  factory EpisodioModel.fromRawJson(String str) =>
      EpisodioModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

abstract class _EpisodioModelBase with Store {
  @observable
  String titulo;
  @observable
  String link;
  @observable
  String info;
  @observable
  String imagem;

  _EpisodioModelBase({this.titulo, this.link, this.info, this.imagem});

  @override
  String toString() => titulo;

  @override
  operator ==(o) => o.titulo == titulo && o.imagem == imagem && o.link == link;

  @override
  int get hashCode =>
      titulo.hashCode ^ imagem.hashCode ^ link.hashCode ^ info.hashCode;
}
