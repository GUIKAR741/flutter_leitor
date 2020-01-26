import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/pagina_imagem/pagina_imagem_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:preload_page_view/preload_page_view.dart';

part 'ler.g.dart';

abstract class Ler extends _LerBase with _$Ler {
  Ler(controller) : super(controller);

  @override
  @mustCallSuper
  void dispose() {
    pageController.dispose();
  }
}

abstract class _LerBase extends Disposable with Store {
  final PreloadPageController pageController = PreloadPageController();

  final dynamic _controller;

  int _index = 0;
  bool _paginacao = true;
  int _paginaIndex;
  List<PaginaImagemWidget> _imagens;

  @observable
  CapituloModel capitulo;
  @observable
  ObservableList<PaginaImagemWidget> imagens;
  @observable
  IconData icone;
  @observable
  String pagina = '';

  _LerBase(this._controller);

  bool get paginacao => _paginacao;
  @protected
  set paginacao(bool value) => _paginacao = value;

  @protected
  int get index => _index;
  @protected
  set index(int value) => _index = value;

  @action
  void pausar() {
    if (_paginacao) {
      pagina = "${_index + 1}/${imagens.length}";
      _imagens = imagens;
      imagens = [imagens[_index]].asObservable();
      icone = Icons.play_arrow;
    } else {
      imagens = _imagens;
      pageController.jumpToPage(_index);
      icone = Icons.pause;
    }
    _paginacao = !_paginacao;
  }

  @action
  void mudar(int pagina) => (pagina > _index) ? proximo() : anterior();

  void escrever(String valor) {
    if (int.tryParse(valor) != null) _paginaIndex = int.parse(valor);
  }

  @action
  void irPara() {
    if (_paginaIndex >= 1 && _paginaIndex <= imagens.length) {
      pagina = "$_paginaIndex/${imagens.length}";
      _index = _paginaIndex;
      pageController.jumpToPage(_index - 1);
    }
  }

  @action
  void anterior() {
    if ((_index--) - 1 >= 0) pagina = "${_index + 1}/${imagens.length}";
  }

  @action
  void proximo() {
    if ((_index++) + 1 < imagens.length)
      pagina = "${_index + 1}/${imagens.length}";
  }

  void listarImagens();

  @action
  void listenerPage(context) {
    if (pageController.position.atEdge) {
      if (pageController.position.extentBefore == 0) {
        int len = _controller.capitulos.value.length;
        bool rev = _controller.isReversed;
        int indice = _controller.capitulos.value.indexOf(capitulo);
        if ((indice < len - 1 && !rev) || (indice > 0 && rev))
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Ir para o Capitulo Anterior"),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text("Não"),
                      onPressed: Modular.to.pop,
                    ),
                    RaisedButton(
                      child: Text("Sim"),
                      onPressed: () {
                        if (indice < len - 1 && !rev)
                          capitulo = _controller.capitulos.value[indice + 1];
                        if (indice > 0 && rev)
                          capitulo = _controller.capitulos.value[indice - 1];
                        listarImagens();
                        Modular.to.pop();
                      },
                    )
                  ],
                );
              });
      } else {
        int len = _controller.capitulos.value.length;
        bool rev = _controller.isReversed;
        int indice = _controller.capitulos.value.indexOf(capitulo);
        if ((indice > 0 && !rev) || (indice < len - 1 && rev))
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Ir para o Proximo Capitulo"),
                actions: <Widget>[
                  RaisedButton(
                    child: Text("Não"),
                    onPressed: Modular.to.pop,
                  ),
                  RaisedButton(
                    child: Text("Sim"),
                    onPressed: () {
                      if (indice > 0 && !rev)
                        capitulo = _controller.capitulos.value[indice - 1];
                      if (indice < len - 1 && rev)
                        capitulo = _controller.capitulos.value[indice + 1];
                      listarImagens();
                      Modular.to.pop();
                    },
                  )
                ],
              );
            },
          );
      }
    }
  }
}
