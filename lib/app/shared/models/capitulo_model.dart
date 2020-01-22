import 'dart:convert';

import 'package:mobx/mobx.dart';
part 'capitulo_model.g.dart';

class CapituloModel extends _CapituloModelBase with _$CapituloModel {
  CapituloModel({String titulo, String link, String info})
      : super(titulo: titulo, link: link, info: info);

  factory CapituloModel.fromJson(Map<String, dynamic> json) {
    return CapituloModel(
      titulo: json['titulo'],
      link: json['link'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titulo': this.titulo,
        'link': this.link,
        'info': this.info,
      };

  factory CapituloModel.fromRawJson(String str) =>
      CapituloModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

abstract class _CapituloModelBase with Store {
  @observable
  String titulo;
  @observable
  String link;
  @observable
  String info;

  _CapituloModelBase({this.titulo, this.link, this.info});

  @override
  String toString() => titulo;

  @override
  operator ==(o) => o.titulo == titulo && o.link == link;

  @override
  int get hashCode => titulo.hashCode ^ link.hashCode ^ info.hashCode;
}
