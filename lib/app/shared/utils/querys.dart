final procurarUsuario = """
query usuario_firebase_id {
  __typename
  usuarios(where: {firebase_id: {_eq: ""}}) {
    id
    firebase_id
  }
}
""";
final inserirUsuario = """
mutation inserir_usuario {
  __typename
  insert_usuarios(objects: {firebase_id: ""}) {
    affected_rows
    returning {
      firebase_id
      id
    }
  }
}
""";
final inserirTitulo = """
mutation inserir_titulo {
  __typename
  insert_titulos(objects: {nome: "", tipo_id: 0}) {
    affected_rows
    returning {
      id
      nome
    }
  }
}
""";
final inserirCapituloEpisodio = """
mutation inserir_capitulo_episodio {
  __typename
  insert_capitulo_episodio(objects: {status: false, titulo: "", titulos_id: 0}) {
    affected_rows
    returning {
      id
      titulo
    }
  }
}
""";
