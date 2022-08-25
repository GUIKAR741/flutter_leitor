import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'capitulo_episodio_model.g.dart';

@HiveType(typeId: 1)
class CapEpModel extends _CapEpModelBase with _$CapEpModel {
  CapEpModel({
    String? titulo,
    String? link,
    String? info,
    String? imagem,
  }) : super(
          titulo: titulo,
          link: link,
          info: info,
          imagem: imagem,
        );

  factory CapEpModel.fromJson(Map<String, dynamic> json) {
    return CapEpModel(
      titulo: json['titulo'],
      link: json['link'],
      info: json['info'],
      imagem: json['imagem'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'link': link,
        'info': info,
        'imagem': imagem,
      };

  factory CapEpModel.fromRawJson(String str) =>
      CapEpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

abstract class _CapEpModelBase extends HiveObject with Store, EquatableMixin {
  @HiveField(0)
  @observable
  String? titulo;

  @HiveField(1)
  @observable
  String? link;

  @observable
  String? info;

  @observable
  String? imagem;

  @observable
  bool status = false;

  _CapEpModelBase({this.titulo, this.link, this.info, this.imagem});

  @computed
  String? get tituloFormatado =>
      titulo?.replaceAll('.', ' ').replaceAll('/', '');

  @action
  void mudarStatus({bool add = false}) => status = !add ? !status : add;

  @override
  String toString() => titulo!;

  @override
  List<Object?> get props => [
        titulo,
        imagem,
        link,
        info,
      ];
}
