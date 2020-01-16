import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class AnimeBloc extends Disposable {
  final AnimeRepository repo;
  final BehaviorSubject<List<Episodio>> _dados =
      BehaviorSubject<List<Episodio>>();
  final ScrollController scrollController = ScrollController();

  Titulo anime;
  List<Episodio> episodios = [];
  bool _isReversed = false;

  AnimeBloc(this.repo);

  Stream<List<Episodio>> get dados => _dados.stream;

  void listarEpisodios() {
    _dados.add(null);
    repo.episodios(anime).then((data) {
      episodios = data;
      _dados.add(data);
    });
  }

  void inverterEpisodios() {
    _dados.add(null);
    repo.episodios(anime).then((data) {
      _dados.add(_isReversed ? data : data.reversed.toList());
      episodios = data;
      _isReversed = !_isReversed;
    });
  }

  void pesquisar(res) {
    _dados.add(null);
    List<Episodio> pesquisa = episodios
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    _dados.add(pesquisa.length > 0 ? pesquisa : episodios);
  }

  void mudarPagina(Episodio episodio) async {
    Modular.to.pushNamed('/assistir', arguments: episodio);
  }

  @override
  void dispose() {
    _dados.close();
    scrollController.dispose();
  }
}
