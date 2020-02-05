import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:flutter_leitor/app/shared/models/capitulo_model.dart';
import 'package:flutter_leitor/app/shared/widgets/ler_controle/ler_controle_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
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
  final LerControleController lerController = LerControleController();

  final ListagemTitulo _controller;

  int _index = 0;
  bool _paginacao = true;
  int _paginaIndex;
  List<Widget> _imagens;
  bool _tap = false;

  @observable
  CapituloModel capitulo;
  @observable
  ObservableFuture<List<Widget>> imagens;
  @observable
  IconData icone;
  @observable
  String pagina = '';

  _LerBase(this._controller) {
    pageController.addListener(listenerPage);
  }

  bool get paginacao => _paginacao;
  @protected
  set paginacao(bool value) => _paginacao = value;

  @protected
  int get index => _index;
  @protected
  set index(int value) => _index = value;

  @action
  void pausar() {
    if (index == -1) return;
    if (_paginacao) {
      pagina = "${_index + 1}/${imagens.value.length}";
      _imagens = imagens.value;
      imagens =
          Future<List<Widget>>.value([imagens.value[_index]]).asObservable();
      icone = Icons.play_arrow;
    } else {
      imagens = Future<List<Widget>>.value(_imagens).asObservable();
      pageController.jumpToPage(_index);
      icone = Icons.pause;
    }
    _paginacao = !_paginacao;
  }

  @action
  void mudar(int pagina) => (pagina > _index) ? proximo() : anterior();

  @action
  void irPara(String valor) {
    Modular.to.pop();
    if (int.tryParse(valor) != null) _paginaIndex = int.parse(valor);
    if (_paginaIndex >= 1 && _paginaIndex <= imagens.value.length) {
      pagina = "$_paginaIndex/${imagens.value.length}";
      _index = _paginaIndex;
      pageController.removeListener(listenerPage);
      pageController.jumpToPage(_index - 1);
      pageController.addListener(listenerPage);
    }
  }

  @action
  void anterior() {
    if ((_index--) - 1 >= 0) pagina = "${_index + 1}/${imagens.value.length}";
  }

  @action
  void proximo() {
    if ((_index++) + 1 < imagens.value.length)
      pagina = "${_index + 1}/${imagens.value.length}";
  }

  void listarImagens();

  @action
  void listenerPage() {
    if (pageController.position.atEdge && paginacao) {
      if (pageController.position.extentBefore == 0) {
        int len = _controller.listagem.length;
        bool rev = _controller.isReversed;
        int indice = _controller.listagem.indexOf(capitulo);
        if ((indice < len - 1 && !rev) || (indice > 0 && rev))
          Get.dialog(
            AlertDialog(
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
                      capitulo = _controller.listagem[indice + 1];
                    if (indice > 0 && rev)
                      capitulo = _controller.listagem[indice - 1];
                    listarImagens();
                    Modular.to.pop();
                  },
                )
              ],
            ),
          );
      } else {
        int len = _controller.listagem.length;
        bool rev = _controller.isReversed;
        int indice = _controller.listagem.indexOf(capitulo);
        if ((indice > 0 && !rev) || (indice < len - 1 && rev))
          Get.dialog(
            AlertDialog(
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
                      capitulo = _controller.listagem[indice - 1];
                    if (indice < len - 1 && rev)
                      capitulo = _controller.listagem[indice + 1];
                    listarImagens();
                    Modular.to.pop();
                  },
                )
              ],
            ),
          );
      }
    }
  }

  void virar() {
    _tap = !_tap;
    if (_tap)
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    else
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
  }
}
