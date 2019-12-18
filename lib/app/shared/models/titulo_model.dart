class Titulo {
  String imagem;
  String link;
  String nome;

  Titulo({this.imagem, this.link, this.nome});

  Titulo.fromJson(Map<String, dynamic> json) {
    imagem = json['imagem'];
    link = json['link'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagem'] = this.imagem;
    data['link'] = this.link;
    data['nome'] = this.nome;
    return data;
  }
}
