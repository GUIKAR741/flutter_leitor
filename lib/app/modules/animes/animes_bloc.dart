import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class AnimesBloc extends Disposable {
  final AnimesRepository repo;
  final ScrollController scrollController = ScrollController();
  final BehaviorSubject<List<Titulo>> _dados = BehaviorSubject<List<Titulo>>();

  List<Titulo> titulos = [];

  AnimesBloc(this.repo) {
    listar();
  }

  Stream<List<Titulo>> get dados => _dados.stream;

  void listar({bool refresh = false}) {
    this._dados.add(null);
    this.repo.pegarAnimes(refresh).then((mangas) {
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
    scrollController.dispose();
  }
}
