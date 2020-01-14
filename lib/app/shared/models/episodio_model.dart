// To parse this JSON data, do
//
//     final Episodio = EpisodioFromJson(jsonString);

import 'dart:convert';

class Episodio {
  String titulo;
  String link;
  String info;
  String imagem;

  Episodio({
    this.titulo,
    this.link,
    this.info = '',
    this.imagem,
  });

  factory Episodio.fromRawJson(String str) =>
      Episodio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => titulo;

  factory Episodio.fromJson(Map<String, dynamic> json) => Episodio(
        titulo: json["titulo"],
        link: json["link"],
        info: json["info"],
        imagem: json["imagem"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "link": link,
        "info": info,
        "imagem": imagem,
      };
}
