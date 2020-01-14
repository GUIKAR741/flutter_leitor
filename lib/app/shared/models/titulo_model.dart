class Titulo {
  String imagem;
  String link;
  String nome;
  String descricao;

  Titulo({this.imagem, this.link, this.nome, this.descricao = ''});

  static Titulo fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Titulo(
        imagem: json['imagem'],
        link: json['link'],
        nome: json['nome'],
        descricao: json['descricao']);
  }

  static List<Titulo> fromJsonList(List json) {
    if (json == null) return null;
    return json.cast<Map<String, dynamic>>().map(fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagem'] = this.imagem;
    data['link'] = this.link;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    return data;
  }

  @override
  String toString() => nome;

  @override
  operator ==(o) => o.nome == nome && o.imagem == imagem && o.link == link;

  @override
  int get hashCode => nome.hashCode ^ imagem.hashCode ^ link.hashCode;
}
