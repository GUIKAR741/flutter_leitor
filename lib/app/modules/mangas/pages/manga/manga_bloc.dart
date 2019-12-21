import 'dart:async';

import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/models/titulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MangaBloc extends Disposable {
  //dispose will be called automatically by closing its streams
  Titulo manga;
  final MangaRepository repo;

  final StreamController<List<Capitulo>> _dados = StreamController<List<Capitulo>>.broadcast();
  Stream<List<Capitulo>> get dados => _dados.stream;

  MangaBloc(this.repo);
  
  listarCapitulos(){
    repo.capitulos(manga.link).then((data){
      _dados.add(data);
    });
  }

  @override
  void dispose() {
    _dados.close();
  }
}
