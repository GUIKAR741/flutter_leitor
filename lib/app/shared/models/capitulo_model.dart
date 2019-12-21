// To parse this JSON data, do
//
//     final capitulo = capituloFromJson(jsonString);

import 'dart:convert';

class Capitulo {
    String titulo;
    String link;

    Capitulo({
        this.titulo,
        this.link,
    });

    factory Capitulo.fromRawJson(String str) => Capitulo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    @override
    String toString() => titulo;

    factory Capitulo.fromJson(Map<String, dynamic> json) => Capitulo(
        titulo: json["titulo"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "link": link,
    };
}
