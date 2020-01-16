import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/mangas_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class MangasBloc extends Disposable {
  final MangasRepository repo;
  final BehaviorSubject<List<Titulo>> _dados = BehaviorSubject<List<Titulo>>();
  final ScrollController scroll = ScrollController();

  List<Titulo> titulos = [];

  MangasBloc(this.repo) {
    listar();
  }

  Stream<List<Titulo>> get dados => _dados.stream;

  void listar({bool refresh = false}) {
    this._dados.add(null);
    this.repo.pegarMangas(refresh).then((mangas) {
      titulos = mangas;
      this._dados.add(mangas);
    });
  }

  void pesquisar(res) {
    List<Titulo> pesquisa = titulos
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    _dados.add(pesquisa.length > 0 ? pesquisa : titulos);
  }

  @override
  void dispose() {
    _dados.close();
    scroll.dispose();
  }
}
