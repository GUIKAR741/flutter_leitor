import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

class AnimeBloc extends Disposable {
  Titulo anime;
  final AnimeRepository repo;
  List<Episodio> episodios = [];
  final BehaviorSubject<List<Episodio>> dados =
      BehaviorSubject<List<Episodio>>();
  bool _isReversed = false;

  AnimeBloc(this.repo);
  final ScrollController scrollController = ScrollController();

  listarEpisodios() {
    dados.add(null);
    repo.episodios(anime).then((data) {
      episodios = data;
      dados.add(data);
    });
  }

  inverterEpisodios() {
    dados.add(null);
    repo.episodios(anime).then((data) {
      dados.add(_isReversed ? data : data.reversed.toList());
      episodios = data;
      _isReversed = !_isReversed;
    });
  }

  void pesquisar(res) {
    dados.add(null);
    List<Episodio> pesquisa = episodios
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    dados.add(pesquisa.length > 0 ? pesquisa : episodios);
  }

  mudarPagina(context, Episodio episodio) async {
    Navigator.pushNamed(context, '/assistir', arguments: episodio);
  }

  @override
  void dispose() {
    dados.close();
  }
}
