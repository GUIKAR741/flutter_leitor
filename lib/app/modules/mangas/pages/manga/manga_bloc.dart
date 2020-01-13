import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

class MangaBloc extends Disposable {
  Titulo manga;
  final MangaRepository repo;
  List<Capitulo> capitulos = [];
  final BehaviorSubject<List<Capitulo>> dados =
      BehaviorSubject<List<Capitulo>>();
  bool _isReversed = false;
  final ScrollController scroll = ScrollController();
  MangaBloc(this.repo);

  listarCapitulos() {
    dados.add(null);
    repo.capitulos(manga).then((data) {
      capitulos = data;
      dados.add(data);
    });
  }

  inverterCapitulos() {
    dados.add(null);
    repo.capitulos(manga).then((data) {
      dados.add(_isReversed ? data : data.reversed.toList());
      capitulos = data;
      _isReversed = !_isReversed;
    });
  }

  void pesquisar(res) {
    dados.add(null);
    List<Capitulo> pesquisa = capitulos
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    dados.add(pesquisa.length > 0 ? pesquisa : capitulos);
  }

  @override
  void dispose() {
    dados.close();
    scroll.dispose();
  }
}
