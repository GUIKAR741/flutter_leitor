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
  void dispose() {
    scroll.dispose();
  }
}

abstract class _AnimeBase extends Disposable with Store {
  final AnimeRepository _repo;
  final ScrollController scroll = ScrollController();

  _AnimeBase(this._repo);

  TituloModel anime;
  @observable
  ObservableFuture<List<EpisodioModel>> episodios;
  bool _isReversed = false;

  @action
  void listarEpisodios({bool reversed = false}) {
    episodios = null;
    episodios = _repo.episodios(anime).then((List<EpisodioModel> data) {
      if (reversed) _isReversed = !_isReversed;
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
