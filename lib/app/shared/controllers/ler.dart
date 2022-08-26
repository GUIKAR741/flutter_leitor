import 'package:asuka/asuka.dart' as asuka;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor/app/shared/controllers/listagem_titulo.dart';
import 'package:leitor/app/shared/models/capitulo_episodio_model.dart';
import 'package:leitor/app/shared/widgets/ler_controle/ler_controle_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:preload_page_view/preload_page_view.dart';

part 'ler.g.dart';

abstract class Ler extends _LerBase with _$Ler {
  Ler(ListagemTitulo controller, CapEpModel capitulo)
      : super(controller, capitulo);

  @override
  @mustCallSuper
  void dispose() {
    if (!_cancel.isCancelled) _cancel.cancel();
    pageController.dispose();
  }
}

abstract class _LerBase extends Disposable with Store {
  final PreloadPageController pageController = PreloadPageController();
  final LerControleController lerController = LerControleController();
  final CancelToken _cancel = CancelToken();

  CancelToken get cancel => _cancel;

  final ListagemTitulo? _controller;

  int _index = 0;
  bool _paginacao = true;
  int? _paginaIndex;
  List<Widget>? _imagens;
  bool _tap = false;

  @observable
  CapEpModel? capitulo;
  @observable
  ObservableFuture<List<Widget>>? imagens;
  @observable
  IconData? icone;
  @observable
  String? pagina = '';

  _LerBase(this._controller, this.capitulo) {
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
      pagina = "${_index + 1}/${imagens!.value!.length}";
      _imagens = imagens!.value!;
      imagens = Future.value([imagens!.value![_index]]).asObservable();
      icone = Icons.play_arrow;
    } else {
      imagens = Future.value(_imagens!).asObservable();
      pageController.jumpToPage(_index);
      icone = Icons.pause;
    }
    _paginacao = !_paginacao;
  }

  @action
  void mudar(int pagina) => (pagina > _index) ? proximo() : anterior();

  @action
  void irPara(BuildContext context, String valor) {
    Navigator.of(context).pop();
    if (int.tryParse(valor) != null) _paginaIndex = int.parse(valor);
    if (_paginaIndex! >= 1 && _paginaIndex! <= imagens!.value!.length) {
      pagina = "$_paginaIndex/${imagens!.value!.length}";
      _index = _paginaIndex!;
      pageController.removeListener(listenerPage);
      pageController.jumpToPage(_index - 1);
      pageController.addListener(listenerPage);
    }
  }

  @action
  void anterior() {
    if ((_index--) - 1 >= 0) pagina = "${_index + 1}/${imagens!.value!.length}";
  }

  @action
  void proximo() {
    if ((_index++) + 1 < imagens!.value!.length) {
      pagina = "${_index + 1}/${imagens!.value!.length}";
    }
  }

  void listarImagens({bool refresh = false});

  @action
  void listenerPage() {
    if (pageController.position.atEdge && paginacao) {
      if (pageController.position.extentBefore == 0) {
        int indice = _controller!.lista!.value!.indexOf(capitulo!);
        if (indice > 0) {
          asuka.showDialog(
            builder: (context) => AlertDialog(
              title: const Text("Ir para o Capitulo Anterior"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Não"),
                ),
                ElevatedButton(
                  child: const Text("Sim"),
                  onPressed: () {
                    capitulo = _controller!.lista!.value![indice - 1];
                    listarImagens();
                    Navigator.of(context).pop();
                    _controller!.addLista(
                      capitulo!.tituloFormatado!,
                      capitulo!,
                      add: true,
                    );
                  },
                )
              ],
            ),
          );
        }
      } else {
        int len = _controller!.lista!.value!.length;
        int indice = _controller!.lista!.value!.indexOf(capitulo!);
        if (indice < len - 1) {
          asuka.showDialog(
            builder: (context) => AlertDialog(
              title: const Text("Ir para o Proximo Capitulo"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Não"),
                ),
                ElevatedButton(
                  child: const Text("Sim"),
                  onPressed: () {
                    capitulo = _controller!.lista!.value![indice + 1];
                    listarImagens();
                    Navigator.of(context).pop();
                    _controller!.addLista(
                      capitulo!.tituloFormatado!,
                      capitulo!,
                      add: true,
                    );
                  },
                )
              ],
            ),
          );
        }
      }
    }
  }

  void virar() {
    _tap = !_tap;
    if (_tap) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }
}
