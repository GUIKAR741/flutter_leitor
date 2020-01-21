import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/mangas/repositories/manga_repository.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:rxdart/rxdart.dart';

class LerBloc extends Disposable {
  final MangaRepository repo;
  final BehaviorSubject<List<PaginaImagemWidget>> _dados =
      BehaviorSubject<List<PaginaImagemWidget>>();
  final BehaviorSubject<String> _pagina = BehaviorSubject<String>();
  final BehaviorSubject<IconData> _icon =
      BehaviorSubject<IconData>.seeded(Icons.pause);
  final PreloadPageController pageController = PreloadPageController();

  Capitulo capitulo;
  List<PaginaImagemWidget> imagens;
  int index = 0;
  bool paginacao = true;
  int paginaIndex;

  LerBloc(this.repo);

  Stream<List<PaginaImagemWidget>> get dados => _dados.stream;
  Stream<String> get pagina => _pagina.stream;
  Stream<IconData> get icon => _icon.stream;

  void listarImagens() {
    _pagina.add(null);
    _dados.add(null);
    repo.imagens(capitulo.link).then((data) {
      index = 0;
      imagens = data.map((String i) => PaginaImagemWidget(url: i)).toList();
      _pagina.add("${index + 1}/${imagens.length}");
      _dados.add(imagens);
    });
  }

  void pausar() {
    if (paginacao) {
      _pagina.add("${index + 1}/${imagens.length}");
      _dados.add([imagens[index]]);
      _icon.add(Icons.play_arrow);
    } else {
      _dados.add(imagens);
      pageController.jumpToPage(index);
      _icon.add(Icons.pause);
    }
    paginacao = !paginacao;
  }

  void mudar(int pagina) {
    (pagina > index) ? proximo() : anterior();
  }

  void escrever(String valor) {
    if (int.tryParse(valor) != null) paginaIndex = int.parse(valor);
  }

  void irPara() {
    if (paginaIndex >= 1 && paginaIndex <= imagens.length) {
      _pagina.add("$paginaIndex/${imagens.length}");
      index = paginaIndex;
      pageController.jumpToPage(index - 1);
    }
    Modular.to.pop();
  }

  void anterior() {
    if ((index--) - 1 >= 0) {
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  void proximo() {
    if ((index++) + 1 < imagens.length) {
      _pagina.add("${index + 1}/${imagens.length}");
    }
  }

  @override
  void dispose() {
    _dados.close();
    _pagina.close();
    _icon.close();
  }
}
