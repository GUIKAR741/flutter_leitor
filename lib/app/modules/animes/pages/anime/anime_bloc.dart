import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnimeBloc extends Disposable {
  Titulo anime;
  final AnimeRepository repo;

  final StreamController<List<Episodio>> _dados =
      StreamController<List<Episodio>>.broadcast();
  Stream<List<Episodio>> get dados => _dados.stream;
  bool _isReversed = false;

  AnimeBloc(this.repo);

  listarEpisodios() {
    repo.episodios(anime.link).then((data) {
      _dados.add(data);
    });
  }

  inverterEpisodios() {
    _dados.add(null);
    repo.episodios(anime.link).then((data) {
      _dados.add(_isReversed ? data : data.reversed.toList());
      _isReversed = !_isReversed;
    });
  }

  mudarPagina(context, Episodio episodio) async {
    Navigator.pushNamed(context, '/assistir', arguments: episodio);
  }

  @override
  void dispose() {
    _dados.close();
  }
}
