import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class MangaBloc extends Disposable {
  final MangaRepository repo;
  final BehaviorSubject<List<Capitulo>> _dados =
      BehaviorSubject<List<Capitulo>>();
  final ScrollController scroll = ScrollController();

  Titulo manga;
  List<Capitulo> capitulos = [];
  bool _isReversed = false;

  MangaBloc(this.repo);

  Stream<List<Capitulo>> get dados => _dados.stream;

  void listarCapitulos() {
    _dados.add(null);
    repo.capitulos(manga).then((data) {
      capitulos = data;
      _dados.add(data);
    });
  }

  void inverterCapitulos() {
    _dados.add(null);
    repo.capitulos(manga).then((data) {
      _dados.add(_isReversed ? data : data.reversed.toList());
      capitulos = data;
      _isReversed = !_isReversed;
    });
  }

  void pesquisar(res) {
    _dados.add(null);
    List<Capitulo> pesquisa = capitulos
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    _dados.add(pesquisa.length > 0 ? pesquisa : capitulos);
  }

  @override
  void dispose() {
    _dados.close();
    scroll.dispose();
  }
}
