import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'anime_controller.g.dart';

class AnimeController extends _AnimeBase with _$AnimeController {
  AnimeController(AnimeRepository _repo) : super(_repo);

  @override
  void dispose() {}
}

abstract class _AnimeBase extends Disposable with Store {
  final AnimeRepository _repo;
  final ScrollController scrollController = ScrollController();

  _AnimeBase(this._repo);

  TituloModel anime;
  @observable
  ObservableFuture<List<EpisodioModel>> episodios;
  bool _isReversed = false;

  @action
  void listarEpisodios() {
    episodios = null;
    episodios = _repo.episodios(anime).asObservable();
  }

  @action
  void inverterEpisodios() {
    episodios = null;
    episodios = _repo.episodios(anime).then((List<EpisodioModel> data) {
      _isReversed = !_isReversed;
      return !_isReversed ? data : data.reversed.toList();
    }).asObservable();
  }

  @action
  List<EpisodioModel> pesquisar(res) {
    List<EpisodioModel> pesquisa = episodios.value
        .where((t) => t.titulo.toLowerCase().contains(res.toLowerCase()))
        .toList();
    return pesquisa.length > 0 ? pesquisa : episodios.value;
  }
}
