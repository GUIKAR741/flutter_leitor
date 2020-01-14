import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/animes_repository.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class AnimesBloc extends Disposable {
  final AnimesRepository repo;
  List<Titulo> titulos = [];
  BehaviorSubject<List<Titulo>> dados = BehaviorSubject<List<Titulo>>();
  final ScrollController scrollController = ScrollController();
  AnimesBloc(this.repo) {
    listar();
  }

  void listar({bool refresh = false}) {
    this.dados.add(null);
    this.repo.pegarAnimes(refresh).then((mangas) {
      titulos = mangas;
      this.dados.add(mangas);
    });
  }

  void pesquisar(res) {
    List<Titulo> pesquisa = titulos
        .where((t) => t.nome.toLowerCase().contains(res.toLowerCase()))
        .toList();
    dados.add(pesquisa.length > 0 ? pesquisa : titulos);
  }

  @override
  void dispose() {
    dados.close();
    scrollController.dispose();
  }
}
