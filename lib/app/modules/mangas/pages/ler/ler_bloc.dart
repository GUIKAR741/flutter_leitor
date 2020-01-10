import 'dart:async';

import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/modules/mangas/widgets/pagina_manga/pagina_manga_widget.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LerBloc extends Disposable {
  Capitulo capitulo;
  final MangaRepository repo;
  List<String> imagens;
  int index = 0;
  final StreamController<List<PaginaMangaWidget>> _dados = StreamController<List<PaginaMangaWidget>>.broadcast();
  Stream<List<PaginaMangaWidget>> get dados => _dados.stream;

  final StreamController<String> _pagina = StreamController<String>.broadcast();
  Stream<String> get pagina => _pagina.stream;

  LerBloc(this.repo);
  
  listarImagens(){
    repo.imagens(capitulo.link).then((data){
      index = 0;
      imagens = data;
      _pagina.add("${index + 1}/${imagens.length}");
      _dados.add(data.map((String i) => PaginaMangaWidget(url: i)).toList());
    });
  }

  mudar(int pagina){
    if(pagina>index) proximo();
    else anterior();
  }

  anterior(){
    if(index - 1 >= 0){
      --index;
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }
  
  proximo(){
    if(index + 1 < imagens.length){
      ++index;
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  @override
  void dispose() {
    _dados.close();
    _pagina.close();
  }
}